from datetime import datetime

from sqlalchemy import MetaData, Table, Column, Integer, String, ForeignKey, JSON, Boolean, Text, DOUBLE_PRECISION

metadata = MetaData()

users = Table(
"users",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("name", String(128), nullable=False),
    Column("surname", String(128), nullable=False),
    Column("email", String(320), nullable=False),
    Column("hashed_password", String, nullable=False),
    Column("photo", String, nullable=True),
    Column("is_active", Boolean, default=True, nullable=False),
    Column("is_superuser", Boolean, default=False, nullable=False),
    Column("is_verified", Boolean, default=False, nullable=False),
)
clients = Table(
    "clients",
    metadata,
    Column("id", Integer, primary_key=True, unique=True),
    Column("name", String(128), nullable=False),
    Column("surname", String(128), nullable=False),
    Column("email", String(320), nullable=False),
    Column("photo", String, nullable=True),
    Column("is_active", Boolean, default=True, nullable=False),
    Column("is_superuser", Boolean, default=False, nullable=False),
    Column("is_verified", Boolean, default=False, nullable=False),
)
companies = Table(
    "companies",
    metadata,
    Column("id", Integer, primary_key=True, unique=True),
    Column("email", String(320), nullable=False),
    Column("name", String(255), nullable=False),
    Column("description", Text, nullable=True),
    Column("is_active", Boolean, default=True, nullable=False),
    Column("is_superuser", Boolean, default=False, nullable=False),
    Column("is_verified", Boolean, default=False, nullable=False),
)
categories = Table(
    "categories",
    metadata,
    Column("id", Integer, primary_key=True, nullable=False),
    Column("name", String(128), nullable=False),
    Column("icon", Boolean, nullable=False),
)
products = Table(
    "products",
    metadata,
    Column("id", Integer, primary_key=True, unique=True, nullable=False),
    Column("company_id", Integer, ForeignKey("companies.id"), nullable=False),
    Column("category", Integer, ForeignKey("categories.id")),
    Column("name", String(255), nullable=False),
    Column("img", String),
    Column("size", String(32)),
    Column("price", DOUBLE_PRECISION, nullable=False),
    Column("amount", Integer, nullable=False),
)
cart = Table(
    "cart",
    metadata,
    Column("client_id", Integer, ForeignKey("clients.id"), primary_key=True, nullable=False),
    Column("product_id", Integer, ForeignKey("products.id"), primary_key=True, nullable=False),
    Column("amount", Integer, nullable=False),
)

