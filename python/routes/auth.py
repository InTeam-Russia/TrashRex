import json

from fastapi import FastAPI, Depends, HTTPException, status, APIRouter
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


auth_router = APIRouter()
Async_Session = async_sessionmaker(engine)


fastapi_users = FastAPIUsers[User, int](
    get_user_manager,
    [auth_backend],
)
current_user = fastapi_users.current_user()

auth_router.include_router(
    fastapi_users.get_auth_router(auth_backend),
    prefix="/user",
    tags=["auth"],
)

auth_router.include_router(
    fastapi_users.get_register_router(UserRead, UserCreate),
    prefix="/user",
    tags=["auth"],
)
@auth_router.get("/auth/whoami",
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
@auth_router.post("/auth/user/{target_id}",
                  tags=["auth"],
                  summary="Select user")
async def select_user(target_id: int):
    async with Async_Session() as session:
        user_row = await session.execute(
            select(users.c.id, users.c.email, users.c.telegram, users.c.vk, users.c.photo, users.c.name,
                   users.c.surname).where(users.c.id == target_id)
        )
        try:
            user_row = user_row.first()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="User not found")
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


