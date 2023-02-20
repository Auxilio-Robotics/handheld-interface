import 'package:firebase_database/firebase_database.dart';

abstract class TeleopServices {
  static Future<void> teleopGripperYaw(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref().child("teleop/gripper/yaw");
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    print(db.path);

    db.set({"x": xVal, "y": yVal});
  }

  static Future<void> teleopNav(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref().child("teleop/nav");
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    print(db.path);

    db.set({"x": xVal, "y": yVal});
  }

  static Future<void> teleopManipulation(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.update({
      "teleop/mani": {"x": xVal, "y": yVal},
    });
  }
  
  static Future<void> teleopGripper(bool open) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    db.update({
      "teleop/gripper/open": open,
    });
  }

  static Future<void> teleopGimbal(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y. toStringAsFixed(5));
    db.update({
      "teleop/gimbal": {"x": xVal, "y": yVal},
    });
  }
}
// robotdisplay