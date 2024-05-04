from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select

from auth.database import User, Async_Session
from models.models import problems
from routes.auth import current_user

events = APIRouter()

@events.get("/events/all",
            tags=["events"],
            summary="Get all events")
async def get_all_events(user: User = Depends(current_user)):
    async with Async_Session() as session:
        results = await session.execute(
            select(problems).order_by(problems.c.id)
        )
        answer = (json.dumps(dict(row._asdict())) for row in results)
        return answer
