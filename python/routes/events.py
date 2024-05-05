import json
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, insert, update
from starlette import status
from starlette.responses import JSONResponse
from auth.database import User, Async_Session
from extra.achivements import added_events_achivement_check, visited_events_achivement_check
from extra.levels import move_level
from models.models import events, event_members, users, user_achivements
from routes.auth import current_user

events_router = APIRouter()


@events_router.get("/events/all",
                   tags=["events"],
                   summary="Get all events")
async def get_all_events(user: User = Depends(current_user)):
    async with Async_Session() as session:
        results = await session.execute(
            select(events).order_by(events.c.id)
        )
        answer = (json.dumps(dict(row._asdict())) for row in results)
        return answer


@events_router.post("/events/create",
                    tags=["events"],
                    summary="Create a new event")
async def create_event(name: str, description: str, lat: float,
                       lon: float, user: User = Depends(current_user)):
    async with Async_Session() as session:

        # Check if event with the same name already exist
        try:
            same_name = await session.execute(
                select(events).where(events.c.name == name)
            )
            same_name = same_name.one()
            raise HTTPException(status_code=409, detail="Event with this name already exists")
        except:
            await session.execute(
                insert(events).values(
                    name=name,
                    description=description,
                    leader_id=user.id,
                    lat=lat,
                    lon=lon,
                    status="preparation"
                )
            )

            # Add achievement if possible
            achivement_id_check = await added_events_achivement_check(user.id)
            if achivement_id_check:
                await session.execute(
                    insert(user_achivements).values(user_id=user.id, achivement_id=achivement_id_check)
                )

            await session.commit()
            return JSONResponse(
                content={
                    "name": name,
                    "description": description,
                    "leader_id": user.id,
                    "lat": lat,
                    "lon": lon,
                    "status": "preparation",
                },
                status_code=status.HTTP_201_CREATED
            )


@events_router.post("/events/join/{event_id}",
                    tags=["events"],
                    summary="Join a specific event"
                    )
async def join_event(event_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        event = await session.execute(
            select(events).where(events.c.id == event_id)
        )
        user_row = await session.execute(
            select(event_members).where(event_members.c.user_id == user.id and
                                        event_members.c.event_id == event_id)
        )

        # Check if event tp join exists
        try:
            event = event.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Event with this ID does not exist")

        # Check if user already participate in the event
        user_row = len(user_row.fetchall())
        if user_row != 0:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail="You have already joined this event")

        # Check if the event hasn't started yet
        if event.status != "preparation":
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                                detail="You can't join already started problem")

        await session.execute(
            insert(event_members).values(
                {"event_id": event_id,
                 "user_id": user.id}
            )
        )

        # Increment event statistic for user
        await session.execute(
            update(users).where(users.c.id == user.id).values(events_visited=users.c.events_visited + 1)
        )

        # Add achievement if possible
        achivement_id_check = await visited_events_achivement_check(user.id)
        if achivement_id_check:
            await session.execute(
                insert(user_achivements).values(user_id=user.id, achivement_id=achivement_id_check))
        await session.commit()

        return {"status": "Enrolled to event"}


@events_router.patch("/events/start/{event_id}",
                     tags=["events"],
                     summary="Start a specific event")
async def start_event(event_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        target_event = await session.execute(
            select(events).where(events.c.id == event_id)
        )

        # Check if the event to start exists
        try:
            target_event = target_event.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Event with this ID does not exist")

        # CHeck if user is leader (Only creator of the event can start it)
        if target_event.leader_id != user.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You are not leader of this event")

        # Check if the event hasn't started
        if target_event.status != "preparation":
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You can start only events that are on preparation stage")

        await session.execute(
            update(events).where(events.c.id == event_id).values(
                {"status": "in_progress"}
            )
        )
        await session.commit()
        return {"status": "Event started!"}


@events_router.patch("/events/finish/{event_id}",
                     tags=["events"],
                     summary="Finish a specific event")
async def finish_event(event_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        event = await session.execute(
            select(events).where(events.c.id == event_id)
        )

        # Check if the event to finish exists
        try:
            event = event.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Event with this ID does not exist")

        # Check if user is leader (Only the creator of the event can finish it)
        if event.leader_id != user.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You are not leader of this event")

        # Check if the event is in progress
        if event.status != "in_progress":
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You can finish only events that are in progress")

        await session.execute(
            update(events).where(events.c.id == event_id).values(
                {"status": "completed"}
            )
        )

        # Increment event statistic for user and add experience
        await session.execute(
            update(users).where(users.c.id == user.id).values(events_added=users.c.events_added + 1,
                                                              exp=users.c.exp + 25)
        )
        session.commit()

        # Move to new level if possible
        new_leader_lvl = await move_level(user.id)
        await session.execute(
            update(users).where(users.c.id == user.id).values(level=new_leader_lvl)
        )

        await session.commit()
        return {"status": "Event finished!"}


@events_router.patch("/events/{event_id}/review_on/{user_id}/{review}",
                     tags=["events"],
                     summary="Make a review on a participant of the event")
async def review_on(event_id: int, user_id: int, review: bool, user: User = Depends(current_user)):
    async with Async_Session() as session:
        event = await session.execute(
            select(events).where(events.c.id == event_id)
        )

        # Check if the event exists
        try:
            event = event.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Event with this ID does not exist")

        # Check if user is leader of this event (Only leader can review on others)
        if event.leader_id != user.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You are not leader of this event")

        # Check if the event is completed (Reviews available only in completed events)
        if event.status != "completed":
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You can review only if event is over")

        participant = await session.execute(
            select(users).where(users.c.id == user_id)
        )

        # Check if participant with {user_id} exists
        try:
            participant = participant.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Participant with this ID does not exist")

        data_of_participant_on_event = await session.execute(
            select(event_members).where(event_members.c.event_id == event_id and event_members.c.user_id == user_id)
        )

        # Check if participant has participated in this event
        try:
            data_of_participant_on_event = data_of_participant_on_event.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Participant with this ID didn't participate in this event")

        # Check if the review on the participant exists
        if data_of_participant_on_event.is_member_good != None:
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                                detail="You have already reviewed this participant")

        await session.execute(
            update(event_members).where(
                event_members.c.event_id == event_id and event_members.c.user_id == user_id).values(
                {"is_member_good": review}
            )
        )
        if review:

            # Add experience to participant if review was positive
            await session.execute(
                update(users).where(users.c.id == event_members.c.user_id).values(exp=users.c.exp + 20).where(
                    event_members.c.event_id == event_id)
            )

            # Move to new level if possible
            new_participant_level = await move_level(participant.id)
            await session.execute(
                update(users).where(users.c.id == participant.id).values(level=new_participant_level)
            )
        await session.commit()
        return {"status": "Review completed!"}
