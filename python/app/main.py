import asyncio

from fastapi import FastAPI, Path, Query, Depends, HTTPException, status
from fastapi_users import FastAPIUsers
from fastapi.responses import JSONResponse
from sqlalchemy import text, insert, select

import os
import sys
sys.path.insert(1, os.path.join(sys.path[0], '..'))

#Pycharm подчёркивает ошибки, но на самом деле в импортах ошибок нет, они фиксятся
#после выполнения команды выше

from auth.auth import auth_backend
from auth.database import User, engine, DATABASE_URL
from auth.manager import get_user_manager
from auth.schemas import UserRead, UserCreate

from models.models import cart

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

@app.get("/auth/is_authorized")
def is_authorized(user: User = Depends(current_user)):
    return {
        "id": user.id,
        "role": user.role
    }

@app.post("/cart/add")
async def add_to_cart(item_id: int, amount: int, user: User = Depends(current_user)):
     conn = await engine.connect()
     await conn.execute(insert(cart).values(client_id=user.id, product_id=item_id, amount=amount))
     await conn.commit()
     return {
         "client_id": user.id,
         "product_id": item_id,
         "amount": amount,
         "message": "New item added to the cart"
     }
