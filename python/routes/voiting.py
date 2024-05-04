from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select, insert, delete, update
from starlette import status

from auth.database import Async_Session, User
from models.models import problems, problem_votes, users
from routes.auth import current_user
from routes.problems import finish_problem

voiting_router = APIRouter()


@voiting_router.post("/voting/vote/{problem_id}",
                     tags=["Voting"],
                     summary="Route for voting on a problem with {problem_id}.")
async def vote_problem(problem_id: int, vote: int, user: User = Depends(current_user)):
    async with Async_Session() as session:
        is_on_voiting = await session.execute(
            select(problems).where(problems.c.id == problem_id)
        )

        # Check if problem for voting exists
        try:
            is_on_voiting = is_on_voiting.one()
        except:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                                detail="Problem with this ID not found")

        # Check if problem is on voting at the moment
        if is_on_voiting.state != "on_voting":
            raise HTTPException(
                status_code=status.HTTP_406_NOT_ACCEPTABLE,
                detail="You can't vote on task which is not on voiting"
            )

        # Check if users has voted before
        user_previous_vote = await session.execute(
            select(problem_votes).where(problem_votes.c.user_id == user.id)
        )
        user_previous_vote = len(user_previous_vote)
        if user_previous_vote > 0:
            raise HTTPException(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                                detail="You have already voted on this problem")

        await session.execute(
            insert(problem_votes).values(
                user_id=user.id,
                problem_id=problem_id,
                vote=vote
            )
        )

        # Add experience to user for voting
        await session.execute(
            update(users).where(users.c.id == user.id).values(exp=users.c.exp + 2)
        )

        await session.commit()

        # Count all votes for this problem
        all_votes = await session.execute(
            select(problem_votes).where(problems.c.id == problem_id)
        )
        all_votes = len(all_votes.all())

        # Count all positive votes for this problem
        positive_votes = await session.execute(
            select(problem_votes).where(problems.c.id == problem_id & vote == 1)
        )
        positive_votes = len(positive_votes.all())

        # Check if problem should be deleted from voting (>10 votes and >60% positive)
        if (positive_votes / all_votes > 0.6) and (all_votes > 10):
            await delete_from_voting(problem_id)

            raise HTTPException(
                status_code=status.HTTP_205_RESET_CONTENT,
                detail="Enough votes and positive votes to complete voting"
            )
        else:
            raise HTTPException(
                status_code=status.HTTP_202_ACCEPTED,
                detail="Your vote has been written!"
            )


async def delete_from_voting(problem_id: int):
    async with Async_Session() as session:
        await finish_problem(problem_id)
        await session.execute(
            delete(problem_votes).where(problem_votes.c.problem_id == problem_id)
        )
        await session.commit()
