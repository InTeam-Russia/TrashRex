import json

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware

from sqlalchemy import insert, select, delete

from auth.database import User, Async_Session

from models.models import problems, problem_votes, users

from routes.auth import auth_router
from routes.events import events_router
from routes.problems import problems_router
from routes.voiting import voiting_router

app = FastAPI()

origins = [
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH"],
    allow_headers=["Content-Type", "Authorization",
                   "Set-Cookie", "Access-Control-Request-Headers",
                   "Access-Control-Allow-Headers"],
)


app.include_router(auth_router)
app.include_router(problems_router)
app.include_router(voiting_router)
app.include_router(events_router)


