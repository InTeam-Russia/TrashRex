from typing import Optional

from fastapi_users import schemas

class UserRead(schemas.BaseUser[int]):
    id: int
    email: str
    hashed_password: str
    is_active: bool = True
    is_superuser: bool = False
    is_verified: bool = False
    telegram: Optional[str] = None
    vk: Optional[str] = None
    photo: Optional[str] = None

class UserCreate(schemas.BaseUserCreate):
    email: str
    is_active: Optional[bool] = True
    is_superuser: Optional[bool] = False
    is_verified: Optional[bool] = False
    telegram: Optional[str] = None
    vk: Optional[str] = None

