from datetime import date
from typing import Optional
from enum import Enum as Enum_
from flask_login import UserMixin

from sqlalchemy import String, ForeignKey, Enum
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app import db

from werkzeug.security import check_password_hash, generate_password_hash

from app import login_manager

@login_manager.user_loader
def load_user(id):
    return db.session.get(User, int(id))

class GenderEnum(Enum_):
    M = "m"
    F = "f"

class User(UserMixin, db.Model):

    __tablename__ = "user"

    # columns

    id: Mapped[int] = mapped_column(primary_key=True)

    first_name: Mapped[str] = mapped_column(String(32), nullable=False)

    last_name: Mapped[str] = mapped_column(String(32))

    date_of_birth: Mapped[date] = mapped_column(nullable=False)
 
    gender: Mapped[GenderEnum] = mapped_column(Enum(GenderEnum), nullable=False)

    email: Mapped[str] = mapped_column(
        String(256), index=True, unique=True, nullable=False
    )

    phone_number: Mapped[str] = mapped_column(
        String(256), index=True, unique=True, nullable=False
    )

    phone_number_last_digits: Mapped[str] = mapped_column(String(3), nullable=False)

    username: Mapped[str] = mapped_column(
        String(32), index=True, unique=True, nullable=False
    )

    password_hash: Mapped[str] = mapped_column(String(256), nullable=False)

    profile_picture_uri: Mapped[Optional[str]] = mapped_column(String(512), nullable=True)

    # Relationships

    articles: Mapped[list["Article"]] = relationship(back_populates="author") #type: ignore
    interests: Mapped[list["UserInterest"]] = relationship(back_populates="user") 
    liked_articles: Mapped[list["Like"]] = relationship(back_populates="user") #type: ignore
    commented_articles: Mapped[list["Comment"]] = relationship( #type: ignore
        back_populates="user"
    ) 

    def __repr__(self):
        return f"<User '{self.id:} - {self.first_name}'>"

    def __init__(
        self,
        first_name: str,
        last_name: str,
        dob: date,
        gender: str,
        email: str,
        phone_number: str,
        phone_number_last_digits: str,
        profile_picture_uri: str | None = None,
    ):
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = dob
        self.gender = gender
        self.email = email
        self.phone_number = phone_number
        self.phone_number_last_digits = phone_number_last_digits
        self.profile_picture_uri = profile_picture_uri if profile_picture_uri is not None else "user_data/profiles/default.png"

    def to_dict(self):
        return {
            "id": self.id,
            "first_name": self.first_name,
            "last_name": self.last_name,
            "date_of_birth": self.date_of_birth.isoformat() if self.date_of_birth else None,
            "gender": self.gender.value if self.gender else None,
            "username": self.username,
            "profile_picture_uri": self.profile_picture_uri,
        }
    
    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
    
    
class UserInterest(db.Model):

    __tablename__ = "user_interest"

    # columns

    category_id: Mapped[int] = mapped_column(
        ForeignKey("category.id"), primary_key=True
    )

    user_id: Mapped[int] = mapped_column(ForeignKey(User.id), primary_key=True)

    # relationships

    user: Mapped["User"] = relationship(back_populates="interests")
    category: Mapped["Category"] = relationship(back_populates="interested_users")

    def __init__(self, category_id: int, user_id: int):
        self.category_id = category_id
        self.user_id = user_id

    def to_dict(self):
        return {
            "category_id": self.category_id,
            "user_id": self.user_id,
        }
