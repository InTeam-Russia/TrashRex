from datetime import datetime

import enum
from sqlalchemy import MetaData, Table, Column, Integer, String, ForeignKey, JSON, Boolean, Text, DOUBLE_PRECISION, Float, DateTime, Enum

metadata = MetaData()

class States(enum.Enum):
    free = "free"
    in_progress = "in_progress"
    on_verification = "on_verification"
    on_voting = "on_voting"
    completed = "completed"

users = Table(
"users",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("email", String(320), nullable=False),
    Column("hashed_password", String(512), nullable=False),
    Column("photo", String(512), nullable=True),
    Column("is_active", Boolean, default=True, nullable=False),
    Column("is_superuser", Boolean, default=False, nullable=False),
    Column("is_verified", Boolean, default=False, nullable=False),
    Column("telegram", String(256), nullable=True),
    Column("vk", String(256), nullable=True),
)
problems = Table(
    "problems",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("description", String, nullable=True),
    Column("photo", String, nullable=False),
    Column("lat", Float, nullable=False),
    Column("lon", Float, nullable=False),
    Column("author_id", Integer, ForeignKey("users.id"), nullable=False),
    Column("solver_id", Integer, ForeignKey("users.id"), nullable=True),
    Column("solution_photo", String, nullable=False),
    Column("state", String, default="free", nullable=False),
)
