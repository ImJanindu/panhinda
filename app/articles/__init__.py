from flask.blueprints import Blueprint
from flask import Blueprint

bp = Blueprint('article', __name__, url_prefix='/article')
