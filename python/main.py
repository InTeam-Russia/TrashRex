import json

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi_users import FastAPIUsers
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware

from sqlalchemy import insert, select, update, delete
from sqlalchemy.ext.asyncio import async_sessionmaker

from auth.auth import auth_backend
from auth.database import User, engine
from auth.manager import get_user_manager
from auth.schemas import UserRead, UserCreate

from models.models import problems, problem_votes, users

app = FastAPI()
Async_Session = async_sessionmaker(engine)

origins = [
    "http://localhost:5173",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"],
    allow_headers=["Content-Type", "Authorization",
                   "Set-Cookie", "Access-Control-Request-Headers",
                   "Access-Control-Allow-Headers"],
)

fastapi_users = FastAPIUsers[User, int](
    get_user_manager,
    [auth_backend],
)

app.include_router(
    fastapi_users.get_auth_router(auth_backend),
    prefix="/user",
    tags=["auth"],
)
app.include_router(
    fastapi_users.get_register_router(UserRead, UserCreate),
    prefix="/user",
    tags=["auth"],
)

current_user = fastapi_users.current_user()

@app.get("/auth/whoami",
         tags=["auth"],
         summary="WhoAmI")
async def whoami(asked_user: User = Depends(current_user)):
    async with Async_Session() as session:
        user_row = await session.execute(
            select(users.c.id, users.c.email, users.c.telegram, users.c.vk, users.c.photo, users.c.name, users.c.surname).where(users.c.id == asked_user.id)
        )
        user_row = user_row.first()
        return JSONResponse(
            status_code=status.HTTP_200_OK,
            content=
            {
            "id": user_row.id,
            "email": user_row.email,
            "telegram": user_row.telegram,
            "vk": user_row.vk,
            "photo": user_row.photo,
            "name": user_row.name,
            "surname": user_row.surname
            }
        )


@app.post("/problems/create",
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

@app.patch("/problems/join/{problem_id}",
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

@app.patch("/problems/finish/{id}",
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

@app.patch("/problems/verificate/{id}",
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

@app.patch("/problems/voting/{id}",
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

@app.get("/problems/all",
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

@app.post("/voting/vote/{problem_id}",
          tags=["Voting"],
          summary="Route for voting on a problem with {problem_id}.")
async def vote_problem(problem_id: int, vote: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        is_on_voiting = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )
        is_on_voiting = is_on_voiting.one()
        if is_on_voiting.state != "on_voting":
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't vote on task which is not on voiting"
            )
        await session.execute(
            insert(problem_votes).values(
                user_id=user.id,
                problem_id=problem_id,
                vote=vote
            )
        )

        await session.commit()

        all_votes = await session.execute(
            select(problem_votes).where(problems.c.id == problem_id)
        )
        all_votes = len(all_votes.all())

        positive_votes = await session.execute(
            select(problem_votes).where(problems.c.id == problem_id & vote == 1)
        )
        positive_votes = len(positive_votes.all())

        if (positive_votes / all_votes > 0.6) and (all_votes > 10):
            await delete_from_voting(problem_id)
            raise HTTPException(
                status_code=status.HTTP_205_RESET_CONTENT,
                detail="Enough votes and positive votes to complete voting"
            )
        else:
            raise HTTPException(
                status_code=status.HTTP_202_ACCEPTED,
                detail="Your vote has been written!"
            )


@app.delete("/voting/delete_from_voting/{problem_id}",
            tags=["Voting"],
            summary="Route for deleting a voting on a problem with {problem_id}.")
async def delete_from_voting(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        await finish_problem(problem_id)
        await session.execute(
            delete(problem_votes).where(problem_votes.c.problem_id == problem_id)
        )
        await session.commit()




