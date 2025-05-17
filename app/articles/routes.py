from app import app
from flask import request, render_template


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
