from datetime import date
from enum import Enum as Enum_
from sqlalchemy import String, ForeignKey, Enum
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app import db


class GenderEnum(Enum_):
    M = "m"
    F = "f"


class User(db.Model):

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

    profile_picture_uri: Mapped[str] = mapped_column(String(512), nullable=True)

    # Reletionships

    articles: Mapped[list["Article"]] = relationship(back_populates="author")
    interests: Mapped[list["UserInterest"]] = relationship(back_populates="user")
    liked_articles: Mapped[list["ArticleLike"]] = relationship(back_populates="user")
    commented_articles: Mapped[list["ArticleComment"]] = relationship(
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
        username: str,
        pwd: str,
        profile_picture_uri: str | None = None,
    ):
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = dob
        self.gender = gender
        self.email = email
        self.phone_number = phone_number
        self.phone_number_last_digits = phone_number_last_digits
        self.username = username
        self.password_hash = pwd
        self.profile_picture_uri = profile_picture_uri


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
