from typing import Optional, Annotated

from fastapi import Query
from fastapi_users import schemas

class UserRead(schemas.BaseUser[int]):
    id: int
    email: str
    is_active: bool = True
    is_superuser: bool = False
    is_verified: bool = False
    telegram: str = None
    vk: str = None
    name: str
    surname: str = None

class UserCreate(schemas.BaseUserCreate):
    email: Annotated[str, Query(pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")]
    password: str
    is_active: Optional[bool] = True
    is_superuser: Optional[bool] = False
    is_verified: Optional[bool] = False
    telegram: str = None
    vk: str = None
    name: str
    surname: str = None

