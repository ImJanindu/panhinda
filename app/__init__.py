from flask import Flask
from config import Config
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate


app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)
migrate = Migrate(app, db)

from app import routes
from app.auth.models import *
from app.article.models import *

from app import auth, article

app.register_blueprint(auth.bp)
app.register_blueprint(article.bp)
