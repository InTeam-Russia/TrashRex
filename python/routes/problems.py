from fastapi import APIRouter
import json
from fastapi import Depends, HTTPException, status
from fastapi.responses import JSONResponse
from sqlalchemy import insert, select, update
from sqlalchemy.exc import NoResultFound

from auth.database import User, engine, Async_Session
from extra.achivements import solved_problems_achivement_check, added_problems_achivement_check
from extra.levels import move_level
from models.models import problems, problem_votes, users, user_achivements
from routes.auth import auth_router, current_user

problems_router = APIRouter()
@problems_router.post("/problems/create",
          tags=["Problems"],
          summary="Route for creating a problem"
          )
async def create_problem(
        description: str, photo: str, lat: float, lon: float,
        user: User = Depends(current_user)):

    async with Async_Session() as session:
        await session.execute(
            insert(problems).values(
            description=description,
            photo=photo,
            lat=lat,
            lon=lon,
            author_id=user.id,
            solver_id=None,
            solution_photo=None
            )
        )

        achivement_id_check = await added_problems_achivement_check(user.id)
        if achivement_id_check:
            await session.execute(insert(user_achivements).values(user_id=user.id, achivement_id=achivement_id_check))
        await session.commit()


        await session.commit()
        return JSONResponse(
                content={
                    "description:": description,
                    "photo": photo,
                    "author_id": user.id,
                    "solver_id": None,
                    "solution_photo": None
                },
                status_code=status.HTTP_201_CREATED
        )

@problems_router.patch("/problems/join/{problem_id}",
           tags=["Problems"],
           summary="Route for joining a problem"
           )
async def join_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        now_state = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )
        try:
            now_state = now_state.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to join not found")

        if now_state.author_id == user.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You can't join yours problem")

        if now_state.state == "free":
            await session.execute(
                update(problems).where(problems.c.id == problem_id).values(
                    {"solver_id": user.id, "state": "in_progress"}
                )
            )
            await session.commit()
        else:
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                                detail="You can't join already started problem"
                                )

@problems_router.patch("/problems/finish/{id}",
           tags=["Problems"],
           summary="Route for finishing a problem"
           )
async def finish_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        now_state = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )
        try:
            now_state = now_state.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to finish not found")

        if (now_state.state == "on_verification") and (now_state.author_id == user.id):
            await session.execute(
                update(problems).where(problems.c.id == problem_id).values(state="completed")
            )
            await session.execute(
                update(users).where(users.c.id == now_state.solver_id).values(problems_solved=users.c.problems_solved + 1,
                                                                                exp=users.c.exp + 15)
            )
            await session.execute(
                update(users).where(users.c.id == user.id).values(problems_added=users.c.problems_added + 1,
                                                                                exp=users.c.exp + 7)
            )
            await session.commit()

            new_solver_lvl = await move_level(now_state.solver_id)
            await session.execute(
                update(users).where(users.c.id == now_state.solver_id).values(level=new_solver_lvl)
            )

            new_user_lvl = await move_level(user.id)
            await session.execute(
                update(users).where(users.c.id == user.id).values(level=new_user_lvl)
            )
            print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
            achivement_id_check = await solved_problems_achivement_check(user.id)
            if achivement_id_check:
                await session.execute(insert(user_achivements).values(user_id=user.id, achivement_id=achivement_id_check))
            await session.commit()
        else:
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't finish a problem which is not yours or not on verification"
            )

@problems_router.patch("/problems/verificate/{id}",
           tags=["Problems"],
           summary="Route for verifying a problem with {id} when it's done."
           )
async def verificate_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        who_is_solver = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )
        try:
            who_is_solver = who_is_solver.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to verificate not found")

        if (who_is_solver.solver_id == user.id) and (who_is_solver.state == "in_progress"):
            await session.execute(
                update(problems).where(problems.c.id == problem_id).values(
                    {"state": "on_verification"}
                )
            )
            await session.commit()
        else:
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't send on verification not yours task or task which is not in progress"
            )

@problems_router.patch("/problems/voting/{id}",
           tags=["Problems"],
           summary="Route for placing a voting on a problem with {id}."
           )
async def voting_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        who_is_author = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )
        try:
            who_is_author = who_is_author.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to send on voting not found")
        if who_is_author.state != "on_verification":
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                                detail="You can't send on voting task which is not on verification")
        if who_is_author.author_id == user.id:
            await session.execute(
                update(problems).where(problems.c.id == problem_id).values(
                    {"state": "on_voting"}
                )
            )
            await session.commit()
        else:
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't send on voting not yours task"
                )

@problems_router.get("/problems/all",
         tags=["Problems"],
         summary="Route for selecting all problems."
         )
async def all_problems():
    async with Async_Session() as session:
        results = await session.execute(
            select(problems).order_by(problems.c.id)
        )
        answer = (json.dumps(dict(row._asdict())) for row in results)
        return answer

@problems_router.get("/problems/all_free",
         tags=["Problems"],
         summary="Route for selecting all free problems."
         )
async def all_free_problems():
    async with Async_Session() as session:
        results = await session.execute(
            select(problems).where(problems.c.state == "free").order_by(problems.c.id)
        )
        answer = (json.dumps(dict(row._asdict())) for row in results)
        return answer

@problems_router.get("/problems/my_problems",
                     tags=["Problems"],
                     summary="Route for selecting problems created by user.")
async def my_problems(user: User = Depends(current_user)):
    async with Async_Session() as session:
        results = await session.execute(
            select(problems).where(problems.c.author_id == user.id)
        )
        answer = (json.dumps(dict(row._asdict())) for row in results)
        return answer

