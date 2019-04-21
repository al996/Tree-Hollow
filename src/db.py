from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Table, Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    nickname = db.Column(db.String, nullable=False)
    join_date = db.Column(db.Integer, nullable=False)
    posts = relationship('Post', cascade='delete')

    def __init__(self, **kwargs):
        self.code = kwargs.get('nickname', '')
        self.code = kwargs.get('join_date', '')


class Post(db.Model):
    __tablename__ = 'posts'
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String, nullable=False)
    nickname = db.Column(db.String, nullable=False)
    upload_date = db.Column(db.Integer, nullable=False)

    def __init__(self, **kwargs):
        self.code = kwargs.get('text', '')
        self.code = kwargs.get('nickname', '')
        self.code = kwargs.get('upload_date', '')

    def serialize(self):
        return {
            'id': self.id,
            'text': self.text,
            'nickname': self.nickname
            'uploaded': self.upload_date
        }


class Tag(db.Model):
    __tablename__ = 'tags'
    id = db.Column(db.Integer, primary_key=True)
    tag = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.code = kwargs.get('tag', '')

    def serialize(self):
        return {
            'id': self.id,
            'tag': self.tag,
        }
