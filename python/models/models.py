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
"user",
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
    Column("name", String(256), nullable=False),
    Column("surname", String(256), nullable=True),
    Column("problems_added", Integer, default=0, nullable=False),
    Column("problems_solved", Integer, default=0, nullable=False),
    Column("events_added", Integer, default=0, nullable=False),
    Column("events_visited", Integer, default=0, nullable=False),
    Column("exp", Integer, default=0, nullable=False),
    Column("level", Integer, default=1, nullable=False),
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
problem_votes = Table(
    "problem_votes",
    metadata,
    Column("user_id", Integer, ForeignKey("users.id"), nullable=False),
    Column("problem_id", Integer, ForeignKey("problems.id"), nullable=False),
    Column("logo", String(256), nullable=False),
)
events = Table(
    "events",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("name", String(200), nullable=False),
    Column("description", Text, nullable=False),
    Column("leader_id", Integer, ForeignKey("users.id"), nullable=False),
    Column("lat", Float, nullable=False),
    Column("lon", Float, nullable=False),
    Column("status", String(64),  nullable=False)
)
event_members = Table(
    "event_members",
    metadata,
    Column("event_id", Integer, ForeignKey("events.id"), nullable=False),
    Column("user_id", Integer, ForeignKey("users.id"), nullable=False),
    Column("is_member_good", Boolean,  nullable=True),
)
achivements = Table(
    "achivements",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("name", String(128), nullable=False),
    Column("description", String(1024), nullable=False),
    Column("logo", String(256), nullable=False)
)
user_achivements = Table(
    "user_achivements",
    metadata,
    Column("user_id", Integer, ForeignKey("users.id"), nullable=False),
    Column("achivement_id", Integer, ForeignKey("achivements.id"), nullable=False),
)