from flask import Flask, render_template, redirect
from flask_sqlalchemy import SQLAlchemy
from alchemy import *

app = Flask(__name__)
db = SQLAlchemy(app)

@app.route('/')
def index():
    return render_template("index.html")


@app.route('/seasons')
def seasons():
    seasonlist = getseasonlist()
    return render_template("seasons.html", seasons=seasonlist)

@app.route('/seasons/<year>')
def seasondetails(year):
    seasondetails = getseasondetails(year)
    return render_template("seasondetails.html", seasondetails=seasondetails, 
                                year=year)

@app.route('/racesummary/<race_id>')
def racesummary(race_id):
    racesummary = getracesummary(race_id)
    racedetails = getracedetails(race_id)
    return render_template("race.html", racesummary=racesummary, racedetails=racedetails)