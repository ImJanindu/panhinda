from flask import request, render_template, flash, redirect, url_for
from app import app
from app.froms import LoginForm, RegisterationForm


@app.route("/", methods=["GET"])
def index():
    if request.method == "GET":
        return render_template("index.html")
    else:
        return "Method not allowed"

