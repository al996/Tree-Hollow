import json
import time
from flask import Flask, request
from db import db, User, Post, Tag
from google.oauth2 import id_token
from google.auth.transport import requests
app = Flask(__name__)
db_filename = 'data.db'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True
db.init_app(app)
with app.app_context():
    db.create_all()
# the dict to return in the event of an invalid request
error_dict = {
    'success': False
}
TH_APP_ID = "1054326645687-jqg2n4pf3iqdufsgni9blo7kcpu6ljed.apps.googleusercontent.com"

@app.route('/api/seed/', methods=['GET'])
def create_seed_data():
    new_user = User(
        google_id="106380710636073572230",
        nickname="littletree",
        join_date=int(time.time())
    )
    db.session.add(new_user)
    constructed_post = Post(
        text="I'm so sad",
        nickname="littletree",
        upload_date=int(time.time()),
        user_id=1
    )
    db.session.add(constructed_post)
    db.session.commit()
    return json.dumps({'success': True})

@app.route('/api/posts/', methods=['GET'])
def get_all_posts():
    posts = Post.query.all()
    response = {
        'success': True,
        'data': [post.serialize() for post in posts]
    }
    return json.dumps(response), 200


@app.route('/api/posts/', methods=['POST'])
def create_a_post():
    # ensure the body is valid JSON
    try:
        post = json.loads(request.data)
    except ValueError:
        return json.dumps(error_dict), 400
    text = post.get("text")
    token = post.get("token")
    # ensure the body is in the expected format
    if len(list(post.keys())) != 2 or text is None\
            or token is None:
        return json.dumps(error_dict), 400
    # validate the user token with google oauth2
    get_params = {
        'token': token
    }
    try:
        idinfo = id_token.verify_oauth2_token(
            token, requests.Request(), TH_APP_ID)

        if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
            raise ValueError('Wrong issuer.')

        # ID token is valid. Get the user's Google Account ID from the decoded token.
        userid = idinfo['sub']
    except ValueError:
        # Invalid token
        print("invalid token supplied.")
        return json.dumps(error_dict), 400
    user = User.query.filter_by(id=userid).first()
    if user is None:
        # the user trying to create a post is not stored in our database.
        # i dont think this should ever happen (hopefully ?)
        return json.dumps(error_dict), 400

    constructed_post = Post(
        text=text,
        nickname=user.nickname,
        upload_date=int(time.time()),
        user_id=userid
    )
    db.session.add(constructed_post)
    db.session.commit()
    response = {
        'success': True,
        'data': constructed_post.serialize()
    }
    return json.dumps(response), 201


@app.route('/api/post/<int:post_id>/', methods=['GET'])
def get_post_by_id(post_id):
    post = Post.query.filter_by(id=post_id).first()
    # ensure a post exists with such id
    if post is None:
        return json.dumps(error_dict), 400
    response = {
        "success": True,
        "data": post.serialize()
    }
    return json.dumps(response), 400


@app.route('/api/post/<int:post_id>/', methods=['POST'])
def edit_post_by_id(post_id):
    pass


@app.route('/api/post/<int:post_id>/token/<string:token>/', methods=['DELETE'])
def delete_post_by_id(post_id, token):
    post = Post.query.filter_by(id=post_id).first()
    if post is None:
        return json.dumps(error_dict), 400
    # validate the user token
    get_params = {
        'token': token
    }
    try:
        idinfo = id_token.verify_oauth2_token(
            token, requests.Request(), TH_APP_ID)

        if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
            raise ValueError('Wrong issuer.')

        # ID token is valid. Get the user's Google Account ID from the decoded token.
        userid = idinfo['sub']
    except ValueError:
        # Invalid token
        return json.dumps(error_dict), 400

    # confirm that the user trying to delete this post is the original author of
    # the post
    if post.user_id != userid:
        return json.dumps(error_dict), 400

    db.session.delete(post)
    db.session.commit()
    response = {
        "success": True,
        "data": post.serialize()
    }
    return json.dumps(response), 200


@app.route('/api/post/<int:post_id>/tags/', methods=['GET'])
def get_tags_by_post_id(post_id):
    pass


@app.route('/api/post/<int:post_id>/tag/', methods=['POST'])
def add_tag_to_post_by_id(post_id):
    pass


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
