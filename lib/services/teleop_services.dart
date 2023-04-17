import 'package:firebase_database/firebase_database.dart';

abstract class FirebaseServices {
  static Future<void> teleopGripperYaw(double x,) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref().child("teleop_commands/manipulator/gripper");
    final double xVal = double.parse(x.toStringAsFixed(5));
    print(db.path);

    db.set({"yaw_position": xVal});
  }

  static Future<void> teleopNav(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref().child("teleop_commands/mobile_base");
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    print(db.path);

    db.set({"vel_x": xVal, "vel_y": yVal}); 
  }

  static Future<void> teleopManipulation(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.update({
      "teleop_commands/manipulator/vel_lift": xVal,
      "teleop_commands/manipulator/vel_extend": yVal,
    });
  }
  
  static Future<void> teleopGripper(bool open) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    db.update({
      "teleop_commands/manipulator/gripper/gripper_open": open,
    });
  }


  static Future<void> switchModes(bool isAutonomous) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    if(!isAutonomous) {
      db.update({
        "operation_mode": "TELEOPERATION",
      });
    } else {
      db.update({
        "operation_mode": "AUTONOMOUS",
      });
    }
  }
  
}
// robotdisplay