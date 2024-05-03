from datetime import datetime

from sqlalchemy import MetaData, Table, Column, Integer, String, ForeignKey, JSON, Boolean, Text, DOUBLE_PRECISION, Float, DateTime

metadata = MetaData()

users = Table(
"users",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("email", String(320), nullable=False),
    Column("hashed_password", String, nullable=False),
    Column("photo", String, nullable=True),
    Column("is_active", Boolean, default=True, nullable=False),
    Column("is_superuser", Boolean, default=False, nullable=False),
    Column("is_verified", Boolean, default=False, nullable=False),
    Column("telegram", String, nullable=True),
    Column("vk", String, nullable=True),
)
problems = Table(
    "problems",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("description", String, nullable=True),
    Column("task_photo", String, nullable=False),
    Column("lat", Float, nullable=False),
    Column("lon", Float, nullable=False),
    Column("author_id", Integer, ForeignKey("users.id"), nullable=False),
    Column("solver_id", Integer, ForeignKey("users.id"), nullable=True),
    Column("solution_photo", String, nullable=False),
    Column("is_solved", Boolean, default=False),
)
