from fastapi import APIRouter
import json
from fastapi import Depends, HTTPException, status
from fastapi.responses import JSONResponse
from sqlalchemy import insert, select, update

from auth.database import User, Async_Session
from extra.achivements import solved_problems_achivement_check, added_problems_achivement_check
from extra.levels import move_level
from models.models import problems, users, user_achivements
from routes.auth import current_user

problems_router = APIRouter()


@problems_router.post("/problems/create",
                      tags=["Problems"],
                      summary="Route for creating a problem")
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

        await session.commit()
        return JSONResponse(
            status_code=status.HTTP_201_CREATED,
            content={
                "description:": description,
                "photo": photo,
                "author_id": user.id,
                "solver_id": None,
                "solution_photo": None
            }
        )


@problems_router.patch("/problems/join/{problem_id}",
                       tags=["Problems"],
                       summary="Route for joining a problem")
async def join_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        problem_row = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )

        # Check if problem with {problem_id} exists
        try:
            problem_row = problem_row.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to join not found")

        # Check if user is not an author
        if problem_row.author_id == user.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail="You can't join yours problem")

        # Check if problem can be joined
        if problem_row.state == "free":
            await session.execute(
                update(problems).where(problems.c.id == problem_id).values(
                    {"solver_id": user.id, "state": "in_progress"}
                )
            )
            await session.commit()
        else:
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                                detail="You can't join already started problem")


@problems_router.patch("/problems/finish/{id}",
                       tags=["Problems"],
                       summary="Route for finishing a problem")
async def finish_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        problem_row = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )

        # Check if problem with {problem_id} exists
        try:
            problem_row = problem_row.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to finish not found")

        # Check if user is author and problem on verification (so solver finished it)
        if (problem_row.state != "on_verification") or (problem_row.author_id != user.id):
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't finish a problem which is not yours or not on verification"
            )

        # Change the status of problem
        await session.execute(
            update(problems).where(problems.c.id == problem_id).values(state="completed")
        )

        # Add experience to solver and author. Increment problem statistic counter for both
        await session.execute(
            update(users).where(users.c.id == problem_row.solver_id).values(
                problems_solved=users.c.problems_solved + 1,
                exp=users.c.exp + 15)
        )
        await session.execute(
            update(users).where(users.c.id == user.id).values(problems_added=users.c.problems_added + 1,
                                                              exp=users.c.exp + 7)
        )
        await session.commit()

        # Move to new level if possible
        new_solver_lvl = await move_level(problem_row.solver_id)
        await session.execute(
            update(users).where(users.c.id == problem_row.solver_id).values(level=new_solver_lvl)
        )

        new_user_lvl = await move_level(user.id)
        await session.execute(
            update(users).where(users.c.id == user.id).values(level=new_user_lvl)
        )

        # Add achievement if possible
        solver_achivement_id_check = await solved_problems_achivement_check(problem_row.solver_id)
        if solver_achivement_id_check:
            await session.execute(insert(user_achivements)
                                  .values(user_id=problem_row.solver_id, achivement_id=solver_achivement_id_check))

        author_achivement_id_check = await added_problems_achivement_check(user.id)
        if author_achivement_id_check:
            await session.execute(insert(user_achivements)
                                  .values(user_id=user.id, achivement_id=author_achivement_id_check))

        await session.commit()


@problems_router.patch("/problems/verificate/{id}",
                       tags=["Problems"],
                       summary="Route for verifying a problem with {id} when it's done.")
async def verificate_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        problem_row = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )

        # Check if problem exists
        try:
            problem_row = problem_row.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to verificate not found")

        # Check if user is solver and problem is in progress
        if (problem_row.solver_id != user.id) or (problem_row.state != "in_progress"):
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't send on verification not yours task or task which is not in progress"
            )

        await session.execute(
            update(problems).where(problems.c.id == problem_id).values(
                {"state": "on_verification"}
            )
        )
        await session.commit()


@problems_router.patch("/problems/voting/{id}",
                       tags=["Problems"],
                       summary="Route for placing a voting on a problem with {id}.")
async def voting_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        problem_row = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )

        # Check if problem exists
        try:
            problem_row = problem_row.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem to send on voting not found")

        # Check if problem is on verification
        if problem_row.state != "on_verification":
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                                detail="You can't send on voting task which is not on verification")

        # Check if user is author of the problem (User can't send on voting his own problem)
        if problem_row.author_id != user.id:
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't send on voting not yours task"
            )

        await session.execute(
            update(problems).where(problems.c.id == problem_id).values(
                {"state": "on_voting"}
            )
        )
        await session.commit()


@problems_router.get("/problems/all",
                     tags=["Problems"],
                     summary="Route for selecting all problems.")
async def all_problems():
    async with Async_Session() as session:
        results = await session.execute(
            select(problems).order_by(problems.c.id)
        )
        answer = (json.dumps(dict(row._asdict())) for row in results)
        return answer


@problems_router.get("/problems/all_free",
                     tags=["Problems"],
                     summary="Route for selecting all free problems.")
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
