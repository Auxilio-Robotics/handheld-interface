import pyrebase
import json

# Read the config file
with open('config.json') as f:
    config = json.load(f)



firebase = pyrebase.initialize_app(config)

auth = firebase.auth()

# Log the user in
user = auth.sign_in_with_email_and_password('pvenkat2@andrew.cmu.edu', 'iamanidiot')

# Get a reference to the database service
db = firebase.database()

# data to save


results = db.child("teleop").get()

json.loads(results)