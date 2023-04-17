import 'package:firebase_database/firebase_database.dart';

// publish last timestamp
abstract class FirebaseServices {
  static Future<void> teleopGripperYaw(
    double x,
  ) async {
    final DatabaseReference db =
        FirebaseDatabase.instance.ref().child("teleop_commands/");
    final double xVal = double.parse(x.toStringAsFixed(5));
    print(db.path);

    db.set({
      "manipulator/yaw_position": xVal,
      'last_command_stamp': DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> teleopNav(double x, double y) async {
    final DatabaseReference db =
        FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    print(db.path);

    db.update({
      "teleop_commands/mobile_base/vel_x": xVal,
      "teleop_commands/mobile_base/vel_y": yVal,
      "teleop_commands/last_command_stamp": DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> teleopManipulation(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.update({
      "teleop_commands/manipulator/vel_lift": yVal,
      "teleop_commands/manipulator/vel_extend": xVal,
      'teleop_commands/last_command_stamp':
          DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> teleopGripper(bool open) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    db.update({
      "teleop_commands/manipulator/gripper_open": open,
      'teleop_commands/last_command_stamp':
          DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> switchModes(bool isAutonomous) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();

    print(isAutonomous);
    if (!isAutonomous) {
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