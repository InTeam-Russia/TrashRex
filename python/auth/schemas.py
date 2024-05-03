from typing import Optional

from fastapi_users import schemas

class UserRead(schemas.BaseUser[int]):
    id: int
    email: str
    hashed_password: str
    role: int
    is_active: bool = True
    is_superuser: bool = False
    is_verified: bool = False


class UserCreate(schemas.BaseUserCreate):
    email: str
    hashed_password: str
    role: int
    is_active: Optional[bool] = True
    is_superuser: Optional[bool] = False
    is_verified: Optional[bool] = False
