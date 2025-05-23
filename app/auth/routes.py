from app import app, db
from flask import request, render_template, redirect, flash, url_for
from flask.blueprints import Blueprint
from flask_login import current_user, login_user
from app.auth.models import User
from app.auth import bp

from sqlalchemy import select
from flask_login import logout_user

from app.validator import LoginForm, RegisterationForm
from app.func import get_sha256_hash


@bp.route("/login", methods=["GET", "POST"])
def login():

    if current_user.is_authenticated:
        return redirect(url_for("index"))

    form = LoginForm()

    if form.validate_on_submit():

        user: User = db.session.scalar(
            select(User).where(User.username == form.username.data)
        )

        if not user:
            flash("Invalid Username")
        else:
            if not user.check_password(form.password.data):
                flash("Incorrect Password")
                return redirect(url_for("auth.login"))

        login_user(user, remember=form.remember_me.data)

        return redirect(url_for("index"))

    return render_template("login.html", form=form)


@bp.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("index"))


@bp.route("/register", methods=["GET", "POST"])
def register():

    if current_user.is_authenticated:
        return redirect(url_for("index"))

    form = RegisterationForm()

    if request.method == "POST":

        if form.validate_on_submit():

            new_user = User(
                first_name=form.first_name.data,
                last_name=form.last_name.data,
                dob=form.dob.data,
                email=form.email.data,
                gender="M" if form.gender.data == "Male" else "F",
                phone_number=get_sha256_hash(form.phone_number.data),
                phone_number_last_digits=form.phone_number.data[-1:-4],
                username=form.username.data,
            )

            new_user.set_password(form.password.data)

            db.session.add(new_user)

            db.session.commit()

            return redirect(url_for("auth.login"))

        else:

            for err in form.errors:
                for e in form.errors[err]:
                    flash(e)

            return render_template("register.html", form=form)

    return render_template("register.html", form=form)
