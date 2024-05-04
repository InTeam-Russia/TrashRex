from fastapi import Depends
from sqlalchemy import insert, select
from auth.database import User, Async_Session
from models.models import users, user_achivements
from routes.auth import current_user

solved_problems_to_achivement_id = {
    1: 1,
    10: 5,
    20: 9,
}
async def solved_problems_achivement_check(user_id):
    async with Async_Session() as session:
        user_row = await session.execute(
            select(users).where(users.c.id == user_id)
        )
        user_row = user_row.one()
        for key in solved_problems_to_achivement_id:
            if user_row.problems_solved == key:
                return solved_problems_to_achivement_id[key]
        return None

added_problems_to_achivement_id = {
    1: 2,
    10: 6,
    20: 9,
}
async def added_problems_achivement_check(user_id):
    async with Async_Session() as session:
        user_row = await session.execute(
            select(users).where(users.c.id == user_id)
        )
        user_row = user_row.one()
        for key in added_problems_to_achivement_id:
            if user_row.problems_added == key:
                return added_problems_to_achivement_id[key]
        return None
visited_events_to_achivement_id = {
    1: 3,
    5: 7,
    10: 11
}
async def visited_events_achivement_check(user_id):
    async with Async_Session() as session:
        user_row = await session.execute(
            select(users).where(users.c.id == user_id)
        )
        user_row = user_row.one()
        for key in visited_events_to_achivement_id:
            if user_row.events_visited == key:
                return visited_events_to_achivement_id[key]
        return None

added_events_to_achivement_id = {
    1: 4,
    3: 8,
    7: 12
}
async def added_events_achivement_check(user_id):
    async with Async_Session() as session:
        user_row = await session.execute(
            select(users).where(users.c.id == user_id)
        )
        user_row = user_row.one()
        for key in added_events_to_achivement_id:
            if user_row.events_added == key:
                return added_events_to_achivement_id[key]
        return None