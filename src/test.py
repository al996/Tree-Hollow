import unittest
import json
import requests
from app import app, db, create_app
from threading import Thread
from time import sleep

# NOTE: Make sure you run 'pip3 install requests' in your virtualenv

# URL pointing to your local dev host
TOKEN = 'ya29.Glv_BmbRCviuaXHfYDgkAHxBnx9YvclaONFUr1M0qkj6TWGySdzzG_DcDFWV9vRJVr5VpWuf38hI5rxMQ-a7XeRgMdKRf1hmAcfYcIVBCC-ISsHW2uu7BRuw5_1h'
TOKEN2 = ''
LOCAL_URL = 'http://localhost:5000'
POSTBODY = {
    'text': 'My secret',
    'token': TOKEN
}
USERBODY = {
    "nickname": "anon",
    "token": TOKEN
}
USER2BODY = {
    "nickname": "littletree",
    "token": TOKEN2
}

def create_test_app(self):
        return create_app()
    
def setUp(self):
        db.create_all()

def tearDown(self):
        db.session.remove()
        db.drop_all()

class TestRoutes(unittest.TestCase):
    

    def test_get_initial_posts(self):
        create_test_app(self)
        setUp(self)
        res = requests.get(LOCAL_URL + '/api/posts/')
        assert res.json()['success']
        tearDown(self)

    def test_register_user(self):
        create_test_app(self)
        setUp(self)
        res = requests.post(LOCAL_URL + '/api/users/',
                            data=json.dumps(USERBODY))
        cls = res.json()['data']
        assert res.json()['success']
        assert cls['nickname'] == 'anon'
        tearDown(self)
        
    
    def test_get_user(self):
        create_test_app(self)
        setUp(self)
        res = requests.post(LOCAL_URL + '/api/users/', data=json.dumps(USERBODY))
        assert res.json()['success']
        res = requests.get(LOCAL_URL + '/api/users/' + TOKEN + '/')
        cls = res.json()['data']
        assert res.json()['success']
        assert cls['nickname'] == 'anon'
        tearDown(self)

    """
    def test_get_users(self):
        requests.post(LOCAL_URL + '/api/users/', data=json.dumps(USERBODY))
        requests.post(LOCAL_URL + '/api/users/', data=json.dumps(USER2BODY))
        res = requests.get(LOCAL_URL + '/api/users/')
        cls = res.json()['data']
        assert res.json()['success']
        user1 = cls[0]
        user2 = cls[1]
        assert user1['nickname'] == 'anon'
        assert user2['nickname'] == 'littletree'

    def test_get_users_none(self):
        res = requests.get(LOCAL_URL + '/api/users/')
        assert res.json()['success']
        print(res.json()['data'])
        assert res.json()['data'] == []

    def create_post(self):
        res = requests.post(LOCAL_URL + '/api/posts/', data=json.dumps(POSTBODY))
        cls = res.json()['data']
        assert res.json()['success']
        assert cls['text'] == 'My secret'
        assert cls['nickname'] == 'anon'

    def get_post(self):"""
"""Need to create a post to get first"""
"""
             res = requests.get(LOCAL_URL + '/api/posts/' + "add id", data=json.dumps(POSTBODY))
             cls = res.json()['data']
             assert res.json()['success']
             post = cls[0]
             assert post['text'] == 'My secret'
             assert post['nickname'] == 'anon'"""

"""
    def test_add_student_to_class(self):
        res = requests.post(LOCAL_URL + '/api/classes/', data=json.dumps(CLASSBODY))
        cls_id = res.json()['data']['id']
        res = requests.post(LOCAL_URL + '/api/users/', data=json.dumps(USERBODY))
        usr_id = res.json()['data']['id']
        body = {'type': 'student', 'user_id': usr_id}
        res = requests.post(LOCAL_URL + '/api/class/' + str(cls_id) + '/add/',
                            data=json.dumps(body))
        assert res.json()['success']

        res = requests.get(LOCAL_URL + '/api/class/' + str(cls_id) + '/')
        assert res.json()['success']
        students = res.json()['data']['students']
        assert len(students) == 1
        assert students[0]['name'] == 'Alicia Wang'

  
    def test_create_assignment_for_class(self):
        res = requests.post(LOCAL_URL + '/api/classes/', data=json.dumps(CLASSBODY))
        cls_id = res.json()['data']['id']
        res = requests.post(LOCAL_URL + '/api/class/' + str(cls_id) + '/assignment/',
                            data=json.dumps(ASSIGNMENTBODY))
        assert res.json()['data']['description'] == 'PA5'
        assert res.json()['data']['due_date'] == 1554076799 

    def test_get_invalid_class(self):
        res = requests.get(LOCAL_URL + '/api/class/1000/')
        assert not res.json()['success']

    def test_delete_invalid_class(self):
        res = requests.delete(LOCAL_URL + '/api/class/1000/')
        assert not res.json()['success']
    
    def test_get_invalid_user(self):
        res = requests.get(LOCAL_URL + '/api/user/1000/')
        assert not res.json()['success']

    def test_add_user_invalid_class(self):
        body = {'type': 'instructor', 'user_id': 0}
        res = requests.post(LOCAL_URL + '/api/class/1000/add/', data=json.dumps(body))
        assert not res.json()['success']

    def test_create_assignment_invalid_class(self):
        res = requests.post(LOCAL_URL + '/api/class/1000/assignment/', 
                            data=json.dumps(ASSIGNMENTBODY))
        assert not res.json()['success']

    def test_cls_id_increments(self):
        res = requests.post(LOCAL_URL + '/api/classes/', data=json.dumps(CLASSBODY))
        cls_id = res.json()['data']['id']

        res2 = requests.post(LOCAL_URL + '/api/classes/', data=json.dumps(CLASSBODY))
        cls_id2= res2.json()['data']['id']

        assert cls_id + 1 == cls_id2 
"""


def run_tests():
    sleep(1.5)
    unittest.main()


if __name__ == '__main__':
    thread = Thread(target=run_tests)
    thread.start()
    app.run(host='0.0.0.0', port=5000, debug=False)
