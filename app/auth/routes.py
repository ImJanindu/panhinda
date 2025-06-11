from app import db
from flask import request, render_template, redirect, flash, url_for, session
from flask_login import current_user, login_user
from app.auth.models import User
from app.auth import bp

from sqlalchemy import select
from flask_login import logout_user
from urllib.parse import urlsplit

from app.utils.validator import (
    LoginForm,
    RegisterationUserDetailsForm,
    ResetPasswordForm,
    RegistretionUserCredentialsForm,
)
from app.utils.func import get_sha256_hash, flash_errors, remove_url_suffix
from app.utils.errors import InternalServerError


@bp.route("/login", methods=["GET", "POST"])
def login():

    if current_user.is_authenticated:
        return redirect(url_for("index"))

    form = LoginForm()

    if request.method == "GET":

        return render_template("auth/login.html", form=form)

    if form.validate_on_submit():

        user: User = db.session.scalar(
            select(User).where(User.username == form.username.data)
        )

        if not user.check_password(form.password.data):
            flash("User Couldn't be Authorized")
            session["attampted_user"] = form.username.data
            flash_errors(form)
            return redirect(url_for("auth.login"))

        login_user(user, remember=form.remember_me.data)

        next_page = request.args.get("next", False)

        if next_page == "None":
            return redirect(url_for("index"))
        else:

            next_page = remove_url_suffix(next_page, ["/react", "/comment"])
            print("?next=" + next_page)

            if not next_page or urlsplit(next_page).netloc != "":
                next_page = url_for("index")

            return redirect(next_page)

    else:
        flash_errors(form)
        return redirect(url_for("auth.login"))


@bp.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("index"))


@bp.route("/reset-password", methods=["GET", "POST"])
def reset_password():

    form = ResetPasswordForm()

    if request.method == "GET":
        return render_template("auth/password_reset.html", form=form)

    if request.method == "POST":

        attampted_login_username = session.pop("attampted_user", None)

        if attampted_login_username is None:
            raise InternalServerError(previous_url=url_for("auth.login"))

        if form.validate_on_submit():

            

            flash('Password Reset Successfull', category='info')
            return redirect(url_for("auth.login"))

        else:
            flash_errors(form)
            return redirect(url_for("auth.reset_password"))


@bp.route("/register/user-details", methods=["GET", "POST"])
def register_user_details():

    if current_user.is_authenticated:
        return redirect(url_for("index"))

    form = RegisterationUserDetailsForm()

    if request.method == "GET":
        return render_template("auth/register/user-details.html", form=form)

    if form.validate_on_submit():

        new_user = User(
            first_name=form.first_name.data,
            last_name=form.last_name.data,
            dob=form.dob.data,
            email=get_sha256_hash(form.email.data),
            gender="M" if form.gender.data == "Male" else "F",
            phone_number=get_sha256_hash(form.phone_number.data),
            phone_number_last_digits=form.phone_number.data[-1:-4],
        )

        session["new_user"] = new_user

        return redirect(url_for("auth.register_user_credentials"))

    else:

        flash_errors(form)

        return redirect(url_for("auth.register_user_details"))


@bp.route("/register/user-credentials", methods=["GET", "POST"])
def register_user_credentials():

    if current_user.is_authenticated:
        return redirect(url_for("index"))

    form = RegistretionUserCredentialsForm()

    if request.method == "GET":
        return render_template("auth/register/user-credentials.html", form=form)

    if form.validate_on_submit():

        if new_user := session.pop('new_user', False):
                
            new_user.username = form.username.data
            new_user.set_password(form.password.data)
            db.session.add(new_user)
            db.session.commit()

            return redirect(url_for("auth.login"))

        else:
            raise InternalServerError(previous_url=url_for('auth.register_user_details'))

    else:

        flash_errors(form)

        return redirect(url_for("auth.register_user_credentials"))
