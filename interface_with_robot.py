import pyrebase
import json
import stretch_body.robot
import time
# Read the config file
with open('config.json') as f:
    config = json.load(f)
    print(config)



firebase = pyrebase.initialize_app(config)

# auth = firebase.auth()

# # Log the user in
# user = auth.sign_in_with_email_and_password('pvenkat2@andrew.cmu.edu', 'iamanidiot')

# Get a reference to the database service
db = firebase.database()

# data to save
curstate = None
moveBot = False
def callback(msg):
    global moveBot, curstate
    curstate = db.child("teleop").get().val()   # childs = msg['path'].split('/')
    # print(curstate.val())
    moveBot = True
    # for child in childs:
    #     curstate[child]
    # msg["data"]

results = db.child("teleop").stream(callback)

r = stretch_body.robot.Robot()

if not r.startup():
    exit() # failed to start robot!

# home the joints to find zero, if necessary
if not r.is_calibrated():
    r.home()
# r.lift.move_by(-0.1)
# r.push_command()

while True:
    if moveBot and curstate is not None:
        # print(curstate['mani']['y'])
        if abs(curstate['nav']['y']) > abs(curstate['nav']['x']):
            r.base.set_translate_velocity(-curstate['nav']['y'])
        else:
            r.base.set_rotational_velocity(-curstate['nav']['x'])
        r.push_command()
        # r.lift.move_by(-curstate['mani']['y'])
        while curstate['mani']['x'] != 0:
            r.arm.move_by(-curstate['mani']['x'])
            r.push_command()
        while curstate['mani']['y'] != 0:
            r.lift.move_by(curstate['mani']['y'])
            r.push_command()
        # time.sleep(0.1)
        
        # if curstate['gripper']['open']:
        
        if curstate['gripper']['open']:
            r.end_of_arm.move_to("stretch_gripper", 100)
        else:
            r.end_of_arm.move_to("stretch_gripper", -50)
        r.push_command()
        moveBot = False

