from fastapi import APIRouter
import json
from fastapi import Depends, HTTPException, status
from fastapi.responses import JSONResponse
from sqlalchemy import insert, select, update
from auth.database import User, engine, Async_Session
from models.models import problems, problem_votes, users
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
        q = insert(problems).values(
            description=description,
            photo= photo,
            lat=lat,
            lon=lon,
            author_id=user.id,
            solver_id=None,
            solution_photo=None
        )

        await session.execute(q)
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
        now_state = now_state.one()

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
        now_state = now_state.one()
        if (now_state.state == "on_verification") and (now_state.author_id == user.id):
            await session.execute(
                update(problems).where(problems.c.id == problem_id).values(
                    {"state": "completed"}
                )
            )
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
        who_is_solver = who_is_solver.one()
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
        who_is_author = who_is_author.one()
        if who_is_author == user.id:
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
async def all_problems(user: User = Depends(current_user)):
    async with Async_Session() as session:
        results = await session.execute(
            select(problems).order_by(problems.c.id)
        )
        answer = (json.dumps(dict(row._asdict())) for row in results)
        return answer

