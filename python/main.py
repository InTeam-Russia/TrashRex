import json

from fastapi import FastAPI, Path, Query, Depends, HTTPException, status
from fastapi.encoders import jsonable_encoder
from fastapi_users import FastAPIUsers
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware


from sqlalchemy import text, insert, select, update, delete
from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker
from sqlalchemy.orm import sessionmaker

from auth.auth import auth_backend
from auth.database import User, engine, DATABASE_URL
from auth.manager import get_user_manager
from auth.schemas import UserRead, UserCreate

from models.models import problems

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
    allow_headers=["Content-Type", "Authorization", "Set-Cookie", "Access-Control-Request-Headers", "Access-Control-Allow-Headers"],
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

@app.get("/protected-route")
def protected_route(user: User = Depends(current_user)):
    return f"Hello, {user.id}"

@app.post("/problems/create")
async def create_problem(description: str, photo_NNN: str, lat: float, lon: float, user: User = Depends(current_user)):
    async with Async_Session() as session:
        q = insert(problems).values(description=description, photo= photo_NNN, lat=lat, lon=lon, author_id=user.id, solver_id=None, solution_photo=None)
        await session.execute(q)
        await session.commit()
        return JSONResponse(content="Done!", status_code=status.HTTP_201_CREATED)

@app.post("/problems/join/{problem_id}")
async def join_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        await session.execute(update(problems).where(problems.c.id == problem_id).values({"solver_id": user.id, "state": "in_progress"}))
        await session.commit()

@app.post("/problems/{command}/{id}")
async def create_command(command: str, problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        if command == "finish":
            await session.execute(update(problems).where(problems.c.id == problem_id).values(
                {"state": "completed"}))
        elif command == "verificate":
            await session.execute(update(problems).where(problems.c.id == problem_id).values(
                {"state": "on_verification"}))
        elif command == "voting":
            await session.execute(update(problems).where(problems.c.id == problem_id).values(
                {"state": "on_voting"}))
        await session.commit()

@app.post("/problems/finish/{id}")
async def finish_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        await session.execute(update(problems).where(problems.c.id == problem_id).values({"state": "in_progress"}))
        await session.commit()

@app.post("/problems/verificate/{id}")
async def finish_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        await session.execute(update(problems).where(problems.c.id == problem_id).values({"state": "on_verification"}))
        await session.commit()

@app.post("/problems/voting/{id}")
async def finish_problem(problem_id: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        await session.execute(update(problems).where(problems.c.id == problem_id).values({"state": "on_voting"}))
        await session.commit()

@app.get("/problems/all")
async def all_problems(user: User = Depends(current_user)):
    async with Async_Session() as session:
        results = await session.execute(select(problems).order_by(problems.c.id))
        answer = json.dumps([(dict(row.items())) for row in results])
        return answer
