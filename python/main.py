import asyncio

from fastapi import FastAPI, Path, Query, Depends, HTTPException, status
from fastapi_users import FastAPIUsers
from fastapi.responses import JSONResponse
from sqlalchemy import text, insert, select

from auth.auth import auth_backend
from auth.database import User, engine, DATABASE_URL, get_async_session
from auth.manager import get_user_manager
from auth.schemas import UserRead, UserCreate

from models.models import problems


app = FastAPI()
session = get_async_session()

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
    return f"Hello, {user.username}"

@app.post("/problems/create")
async def create_problem(description: str, problem_photo: str, lat: float, lon: float, user: User = Depends(current_user)):
    q = insert(problems).values(description = description, problem_photo = problem_photo, lat = lat, lon = lon, author_id = user.id)
    await session.execute(q)
    await session.commit()

@app.post("/problems/join/{problem_id}")
async def join_problem(problem_id: int, user: User = Depends(current_user)):
    problem = problems.query.filter_by(problem_id = problem_id).first()
    problem.author_id = user.id
    problem.state = "in_progress"
    await session.commit()

@app.post("/problems/{command}/{id}")
async def create_command(command: str, id: int, user: User = Depends(current_user)):
    problem = problems.query.filter_by(problem_id = problem_id).first()
    if command == "finish":
        problem.state = "completed"
    elif command == "verificate":
        problem.state = "on_verification"
    elif command == "voting":
        problem.state = "on_voting"
    await session.commit()

@app.get("/problems/all")
async def all_problems(user: User = Depends(current_user)):
    problems = problems.query.all()
    return JSONResponse(problems)
