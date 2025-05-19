import os

basedir = os.path.abspath(os.path.dirname(__file__))

class Config:
    SECRET_KEY = os.environ.get("SECRET_KEY") or os.urandom(128)
    SQLALCHEMY_DATABASE_URI = (
        os.environ.get("DATABASE_URI") or f"sqlite:///{os.path.join(basedir, 'app.db')}"
    )
    SESSION_PERMANENT=False
    SESSION_TYPE='filesystem'
    USER_DATA_PATH=os.path.join(basedir, 'static\\user_data')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
