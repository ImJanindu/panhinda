from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase
from flask_migrate import Migrate
from flask_login import LoginManager


app = Flask(__name__)
app.config.from_object(Config)

db: SQLAlchemy = SQLAlchemy(app)
migrate = Migrate(app, db)
login_manager = LoginManager(app)

login_manager.login_view = 'auth.login'

from app import routes
from app.auth import routes
from app.articles import routes
from app.auth.models import *
from app.articles.models import *

from app import auth, articles

app.register_blueprint(auth.bp)
app.register_blueprint(articles.bp)
