import json
import time
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from db import db, User, Post, Tag
import requests

db = SQLAlchemy()

def create_test_app():
    app = Flask(__name__)
    db_filename = 'data.db'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_ECHO'] = True
    # Dynamically bind SQLAlchemy to application
    db.init_app(app)
    app.app_context().push() # this does the binding
    return app