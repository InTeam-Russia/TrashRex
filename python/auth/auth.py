from fastapi_users.authentication import CookieTransport, AuthenticationBackend
import os
import sys
sys.path.insert(1, os.path.join(sys.path[0], '..'))

from app.config import JWT_SECRET_CODE

cookie_transport = CookieTransport(cookie_max_age=3600, cookie_name="Auth_cookie")

from fastapi_users.authentication import JWTStrategy

SECRET = JWT_SECRET_CODE

def get_jwt_strategy() -> JWTStrategy:
    return JWTStrategy(secret=SECRET, lifetime_seconds=3600)

auth_backend = AuthenticationBackend(
    name="jwt",
    transport=cookie_transport,
    get_strategy=get_jwt_strategy,
)