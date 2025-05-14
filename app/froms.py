from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, RadioField, SelectField
from wtforms import EmailField, BooleanField, SubmitField, DateField
from wtforms.validators import Length, EqualTo, DataRequired, InputRequired, Regexp
from wtforms.validators import email

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[InputRequired()])
    remember_me = BooleanField('Remember Me')
    submit = SubmitField('Continue')


class RegisterationForm(FlaskForm):
    fullname = StringField('Fullname', validators=[DataRequired(), Regexp(r'^([A-Za-z]+/s?){1,}$', message='Invalid Fullname')])
    dob = DateField('Date of Birth', validators=[DataRequired()])
    gender = RadioField('Gender', choices=['Male', 'Female'], validators=[InputRequired()])
    email = EmailField('Email', validators=[email(message='Invalid Email'), DataRequired()])
    phone_number = StringField("Phone Number", validators=[DataRequired(), Regexp(r'^(\+94|0)[0-9]{9}$')])
    username = StringField("Username", validators=[DataRequired()])
    password = StringField("Password", validators=[Regexp(r'[.]{8,}', message='Password should have aleast 8 characters')])
    verify_password =  StringField("Retype Password", validators=[EqualTo('password', message='Password Verification Failed')])
    submit = SubmitField('Continue')