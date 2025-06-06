from flask import request, render_template, flash, redirect, url_for
from app import app
from app.utils.validator import *

@app.errorhandler(Exception)
def render_error_page(e):
    return render_template('error.html', error=e)


@app.route("/", methods=["GET"])
def index():
    if request.method == "GET":
        return render_template("index.html")
    else:
        return "Method not allowed"

