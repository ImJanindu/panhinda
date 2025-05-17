from app import app
from flask import request, render_template, redirect, flash, url_for

from app.froms import LoginForm, RegisterationForm

@app.route("/login", methods=["GET", "POST"])
def login():

    form = LoginForm()

    if form.validate_on_submit():
        
        flash(f"Login requested for user {form.username.data}, remember_me={form.remember_me.data}")
        
        return redirect(url_for('view_index'))
    

    return render_template("login.html", form=form, **form.data)


@app.route("/register", methods=["GET", "POST"])
def register():

    form = RegisterationForm()

    if form.validate_on_submit():
        return redirect('/login')

    return render_template("register.html", form=form)
