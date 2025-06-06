from hashlib import sha256

from flask import flash
from flask_wtf import FlaskForm


def get_sha256_hash(data: str) -> str:
    hashed_method = sha256()
    hashed_method.update(data.encode())
    return hashed_method.hexdigest()

def flash_errors(form: FlaskForm) -> None:
    for field, errors in form.errors.items():
        for err in errors:
            flash(err)

def remove_url_suffix(url: str, suffix: str|list[str]) -> str:
    if type(suffix) == list:
        for sfx in suffix:
            url = url.removesuffix(sfx)
    elif type(suffix) == str:
        url = url.removesuffix(sfx)
    return url