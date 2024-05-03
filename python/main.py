import asyncio

from fastapi import FastAPI, Path, Query, Depends, HTTPException, status
from fastapi_users import FastAPIUsers
from fastapi.responses import JSONResponse
from sqlalchemy import text, insert, select

from auth.auth import auth_backend
from auth.database import User, engine, DATABASE_URL
from auth.manager import get_user_manager
from auth.schemas import UserRead, UserCreate

from models.models import problems

app = FastAPI()

fastapi_users = FastAPIUsers[User, int](
    get_user_manager,
    [auth_backend],
)

app.include_router(
    fastapi_users.get_auth_router(auth_backend),
    prefix="/auth",
    tags=["auth"],
)
app.include_router(
    fastapi_users.get_register_router(UserRead, UserCreate),
    prefix="/auth",
    tags=["auth"],
)

current_user = fastapi_users.current_user()

@app.get("/protected-route")
def protected_route(user: User = Depends(current_user)):
    return f"Hello, {user.username}"
