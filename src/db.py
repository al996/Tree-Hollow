from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Table, Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    google_id = db.Column(db.String, nullable=False)
    nickname = db.Column(db.String, nullable=False)
    join_date = db.Column(db.Integer, nullable=False)
    posts = db.relationship('Post', cascade='delete')

    def __init__(self, **kwargs):
        self.google_id = kwargs.get('google_id', '')
        self.nickname = kwargs.get('nickname', '')
        self.join_date = kwargs.get('join_date', '')


class Post(db.Model):
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String, nullable=False)
    nickname = db.Column(db.String, nullable=False)
    upload_date = db.Column(db.Integer, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey(
        'users.id'), nullable=False)

    def __init__(self, **kwargs):
        self.text = kwargs.get('text', '')
        self.nickname = kwargs.get('nickname', '')
        self.upload_date = kwargs.get('upload_date', '')
        self.user_id = kwargs.get('user_id', 0)

    def serialize(self):
        return {
            'id': self.id,
            'text': self.text,
            'nickname': self.nickname,
            'uploaded': self.upload_date
        }


class Tag(db.Model):
    __tablename__ = 'tags'
    id = db.Column(db.Integer, primary_key=True)
    tag = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.tag = kwargs.get('tag', '')

    def serialize(self):
        return {
            'id': self.id,
            'tag': self.tag,
        }
