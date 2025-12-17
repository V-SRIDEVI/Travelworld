import os
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase


class Base(DeclarativeBase):
    pass


db = SQLAlchemy(model_class=Base)


def init_db(app):
    """Initialize database with Flask app"""
    # Only set SQLALCHEMY_DATABASE_URI from the environment if provided
    # and avoid overwriting any value already set on the app (e.g. in main.py).
    database_url = os.environ.get("DATABASE_URL")
    if database_url and not app.config.get("SQLALCHEMY_DATABASE_URI"):
        app.config["SQLALCHEMY_DATABASE_URI"] = database_url

    # Ensure sensible engine options are present, but do not clobber
    # any options the app may already have configured.
    default_engine_options = {
        "pool_recycle": 300,
        "pool_pre_ping": True,
    }
    existing_opts = app.config.get("SQLALCHEMY_ENGINE_OPTIONS") or {}
    # Merge defaults without overwriting explicit app settings
    merged_opts = {**default_engine_options, **existing_opts}
    app.config["SQLALCHEMY_ENGINE_OPTIONS"] = merged_opts

    db.init_app(app)
