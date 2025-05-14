from flask import request, render_template, flash, redirect, url_for
from app import app
from app.froms import LoginForm, RegisterationForm


@app.route("/", methods=["GET"])
def view_index():
    if request.method == "GET":
        return render_template("index.html")
    else:
        return "Method not allowed"


@app.route("/articles", methods=["GET", "POST"])
def view_articles():
    if request.method == "GET":
        return render_template("articles.html")
    else:
        return "Method not allowed"


@app.route("/article/<int:id>", methods=["GET", "POST"])
def view_article(id: int):
    if request.method == "GET":
        return render_template("article.html")
    else:
        return "Method not allowed"


@app.route("/create", methods=["GET", "POST"])
def view_create_article():
    if request.method == "GET":
        return render_template("create.html")
    else:
        return "Method not allowed"


@app.route("/login", methods=["GET", "POST"])
def view_login():

    form = LoginForm()

    if form.validate_on_submit():
        flash(f"Login requested for user {form.username.data}, remember_me={form.remember_me.data}")
        return redirect(url_for('view_index'))
    

    return render_template("login.html", form=form, **form.data)


@app.route("/register", methods=["GET", "POST"])
def view_signup():

    form = RegisterationForm()

    if form.validate_on_submit():
        return redirect('/login')

    return render_template("register.html", form=form)
