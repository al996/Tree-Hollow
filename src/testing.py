from flask.ext.testing import TestCase
from myapp import create_test_app, db

class MyTest(TestCase):    # I removed some config passing here
    def create_app(self):
        return create_test_app()

    def setUp(self):
        db.create_all()

    def tearDown(self):
        db.session.remove()
        db.drop_all()