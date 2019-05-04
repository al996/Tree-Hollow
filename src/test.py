import unittest
import json
import requests
from app import app
from threading import Thread
from time import sleep

# NOTE: Make sure you run 'pip3 install requests' in your virtualenv

# URL pointing to your local dev host
LOCAL_URL = 'http://localhost:5000'
POSTBODY = {'text': 'My secret', 'nickname': 'anon'}
USERBODY = {'nickname': 'anon', 'token': 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjVkODg3ZjI2Y2UzMjU3N2M0YjVhOGExZTFhNTJlMTlkMzAxZjgxODEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxMDU0MzI2NjQ1Njg3LWpxZzJuNHBmM2lxZHVmc2duaTlibG83a2NwdTZsamVkLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiMTA1NDMyNjY0NTY4Ny1qcWcybjRwZjNpcWR1ZnNnbmk5YmxvN2tjcHU2bGplZC5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjEwNjM4MDcxMDYzNjA3MzU3MjIzMCIsImhkIjoiY29ybmVsbC5lZHUiLCJlbWFpbCI6ImpkOTUyQGNvcm5lbGwuZWR1IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJkdDBIUG8wbFMwUnUzNzNVQ3duaXZBIiwibmFtZSI6Ikp1bnJ1aSBEZW5nIiwicGljdHVyZSI6Imh0dHBzOi8vbGg0Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tVFJWT3IwaHZvdXMvQUFBQUFBQUFBQUkvQUFBQUFBQUFBSEkvRnZUTHFvRUEyMVEvczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6Ikp1bnJ1aSIsImZhbWlseV9uYW1lIjoiRGVuZyIsImxvY2FsZSI6ImVuIiwiaWF0IjoxNTU2OTEwNDk4LCJleHAiOjE1NTY5MTQwOTh9.JFbS-GeeMSIu_jATHpZeGJpWCeN_swBZpaj5v0EBtBrqZCbm8afXg8ti7PkhN5oPidB-OX467c1lYKIAePuzVpTVKx7IQRhpU9fp3LcqemKiiXzeVVpVJh0Iwpkk6iPd6oH2VMeHv5TBeSKlwjS6_pkXpz_61EbtXK29T-M17Jm0NSalt_CMK2FNH-zl-2DEK20aaHnx7JF_y0szp2fgE6TCRtERe4sKoruTH8BMNQ7oVhoT3ARQLEnJjjZJ5fEtIW8BbhAdjJwpf3gwXAnddEL9EK9mHmYs5oDmWNLOg3sHh5RRLUjHazDqw3x1b4X7BrBZArnuyg3wexwnaXBE1w'}

class TestRoutes(unittest.TestCase):

    def test_get_initial_posts(self):
        res = requests.get(LOCAL_URL + '/api/posts/')
        assert res.json()['success']
   
    def test_register_user(self):
        res = requests.post(LOCAL_URL + '/api/users/', data=json.dumps(USERBODY))
        cls = res.json()['data']
        assert res.json()['success']
        assert cls['id'] == 1
        assert cls['nickname'] == 'anon'
        
    def test_get_user(self):
        res = requests.post(LOCAL_URL + '/api/users/', data=json.dumps(USERBODY))
        res = requests.get(LOCAL_URL + '/api/users/eyJhbGciOiJSUzI1NiIsImtpZCI6IjVkODg3ZjI2Y2UzMjU3N2M0YjVhOGExZTFhNTJlMTlkMzAxZjgxODEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxMDU0MzI2NjQ1Njg3LWpxZzJuNHBmM2lxZHVmc2duaTlibG83a2NwdTZsamVkLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiMTA1NDMyNjY0NTY4Ny1qcWcybjRwZjNpcWR1ZnNnbmk5YmxvN2tjcHU2bGplZC5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjEwNjM4MDcxMDYzNjA3MzU3MjIzMCIsImhkIjoiY29ybmVsbC5lZHUiLCJlbWFpbCI6ImpkOTUyQGNvcm5lbGwuZWR1IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJkdDBIUG8wbFMwUnUzNzNVQ3duaXZBIiwibmFtZSI6Ikp1bnJ1aSBEZW5nIiwicGljdHVyZSI6Imh0dHBzOi8vbGg0Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tVFJWT3IwaHZvdXMvQUFBQUFBQUFBQUkvQUFBQUFBQUFBSEkvRnZUTHFvRUEyMVEvczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6Ikp1bnJ1aSIsImZhbWlseV9uYW1lIjoiRGVuZyIsImxvY2FsZSI6ImVuIiwiaWF0IjoxNTU2OTEwNDk4LCJleHAiOjE1NTY5MTQwOTh9.JFbS-GeeMSIu_jATHpZeGJpWCeN_swBZpaj5v0EBtBrqZCbm8afXg8ti7PkhN5oPidB-OX467c1lYKIAePuzVpTVKx7IQRhpU9fp3LcqemKiiXzeVVpVJh0Iwpkk6iPd6oH2VMeHv5TBeSKlwjS6_pkXpz_61EbtXK29T-M17Jm0NSalt_CMK2FNH-zl-2DEK20aaHnx7JF_y0szp2fgE6TCRtERe4sKoruTH8BMNQ7oVhoT3ARQLEnJjjZJ5fEtIW8BbhAdjJwpf3gwXAnddEL9EK9mHmYs5oDmWNLOg3sHh5RRLUjHazDqw3x1b4X7BrBZArnuyg3wexwnaXBE1w/')
        cls = res.json()['data']
        assert res.json()['success']
        assert cls['id'] == 1
        assert cls['nickname'] == 'anon'


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
