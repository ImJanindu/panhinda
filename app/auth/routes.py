from app import app, db
from flask import request, render_template, redirect, flash, url_for
from flask_login import current_user, login_user
from app.auth.models import User
from app.auth import bp

from sqlalchemy import select
from flask_login import logout_user

from app.utils.validator import LoginForm, RegisterationForm
from app.utils.func import get_sha256_hash, flash_errors, remove_url_suffix
from urllib.parse import urlsplit


@bp.route("/login", methods=["GET", "POST"])
def login():

    if current_user.is_authenticated:
        return redirect(url_for("index"))

    form = LoginForm()

    if request.method == "GET":

        return render_template("login.html", form=form)

    if form.validate_on_submit():

        user: User = db.session.scalar(
            select(User).where(User.username == form.username.data)
        )

        if not user.check_password(form.password.data):
            flash("User Couldn't be Authorized")
            flash_errors(form)
            return redirect(url_for("auth.login"))

        login_user(user, remember=form.remember_me.data)

        next_page = request.args.get('next', False)

        if next_page == 'None':
            return redirect(url_for('index'))
        else:

            next_page = remove_url_suffix(next_page, ['/react', '/comment'])
            print('?next='+next_page)
        
            if not next_page or urlsplit(next_page).netloc != '':
                next_page = url_for('index')
            
            return redirect(next_page)

    else:

        flash_errors(form)
        return redirect(url_for("auth.login"))


@bp.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("index"))


@bp.route("/register", methods=["GET", "POST"])
def register():

    if current_user.is_authenticated:
        return redirect(url_for("index"))

    form = RegisterationForm()

    if request.method == "GET":
        return render_template("register.html", form=form)

    if form.validate_on_submit():

        new_user = User(
            first_name=form.first_name.data,
            last_name=form.last_name.data,
            dob=form.dob.data,
            email=get_sha256_hash(form.email.data),
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

        flash_errors(form)

        return redirect(url_for("auth.register"))

