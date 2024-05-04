from sqlalchemy import select, update, delete

from auth.database import Async_Session
from models.models import users, problems

exp_to_levels = {
    0: 1,
    10: 2,
    30: 3,
    60: 4,
    100: 5,
    140: 6,
    180: 7,
    220: 8,
    260: 9,
    310: 10,
    360: 11
}

async def move_level(user_id):
    async with Async_Session() as session:
        user_row = await session.execute(
            select(users).where(users.c.id == user_id)
        )
        user_row = user_row.one()
        temp_lvl = 0
        for key in exp_to_levels:
            if user_row.exp >= key:
                temp_lvl = exp_to_levels[key]
        return temp_lvl
