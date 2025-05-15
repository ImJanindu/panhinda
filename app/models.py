from datetime import datetime, timezone, date
from typing import Optional, Literal
import sqlalchemy as sa
import sqlalchemy.orm as so
from app import db


class GenderEnum(str, sa.Enum):
    M = 'm'
    F = 'f'


class User(db.Model):

    __tablename__ = 'user'

    # columns

    id: so.Mapped[int] = so.mapped_column(primary_key=True)

    first_name: so.Mapped[str] = so.mapped_column(sa.String(32), nullable=False)

    last_name: so.Mapped[str] = so.mapped_column(sa.String(32))

    date_of_birth: so.Mapped[date] = so.mapped_column(nullable=False)

    gender: so.Mapped[GenderEnum] = so.mapped_column(sa.Enum(GenderEnum), nullable=False)

    email: so.Mapped[str] = so.mapped_column(sa.String(120), index=True, unique=True, nullable=False)

    phone_number: so.Mapped[str] = so.mapped_column(sa.String(256), index=True, unique=True, nullable=False)

    username: so.Mapped[str] = so.mapped_column(sa.String(32), index=True, unique=True, nullable=False)

    password_hash: so.Mapped[str] = so.mapped_column(sa.String(256), nullable=False)
    
    profile_picture_uri: so.Mapped[str] = so.mapped_column(sa.String(512), nullable=True)  

    # Reletionships

    article: so.WriteOnlyMapped["Article"] = so.relationship(back_populates="author")

    def __repr__(self):
        return f"<User {self.id:(self.first_name)}>"


class Article(db.Model):

    __tablename__ = 'article'

    #columns

    id: so.Mapped[int] = so.mapped_column(primary_key=True)
    
    author_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey(User.id), index=True, nullable=False)

    title: so.Mapped[str] = so.mapped_column(sa.String(128), unique=True, nullable=False)
    
    description: so.Mapped[str] = so.mapped_column(sa.String(256), unique=True, nullable=False)

    body: so.Mapped[str] = so.mapped_column(sa.String(2048))

    created: so.Mapped[datetime] = so.mapped_column(
        index=True, default=lambda: datetime.now(timezone.utc)
    )

    author: so.Mapped[User] = so.relationship(back_populates="article")

    def __repr__(self):
        return "<Post {}>".format(self.body)

class Category(db.Model):

    __tablename__ = 'category'

    id: so.Mapped[int] = so.mapped_column(primary_key=True)

    label: so.Mapped[str] = so.mapped_column(sa.String(32))

    sub_category: so.WriteOnlyMapped["SubCategory"] = so.relationship(back_populates="sub_category")

class SubCategory(db.Model):

    __tablename__ = 'sub_category'

    id: so.Mapped[int] = so.mapped_column(primary_key=True)

    label: so.Mapped[str] = so.mapped_column(sa.String(32))

    category_id: so.Mapped[str] = so.mapped_column(sa.ForeignKey(Category.id), index=True, nullable=False)

    category: so.Mapped[Category] = so.relationship(back_populates='category')

class user_interest(db.Model):

    __tablename__ = 'user_interest'

    id: so.Mapped[int] = so.mapped_column(primary_key=True)

    category_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey(Category.id), index=True, nullable=False)

    user_id: so.Mapped[int] = so.mapped_column(sa.ForeignKey(User.id), index=True, nullable=False)

    


