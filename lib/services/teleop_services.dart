import 'package:firebase_database/firebase_database.dart';

// publish last timestamp
abstract class FirebaseServices {
  static Future<void> teleopGripperYaw(
    double x,
  ) async {
    final DatabaseReference db =
        FirebaseDatabase.instance.ref();
    double xVal = 360 - double.parse(x.toStringAsFixed(5));
    xVal -= 180;
    print(db.path);

    db.update({
      "alfred_fvd/teleop_commands/manipulator/yaw_position": xVal,
      'alfred_fvd/teleop_commands/last_command_stamp': DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> teleopNav(double x, double y) async {
    final DatabaseReference db =
        FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    print(db.path);

    db.update({
      "alfred_fvd/teleop_commands/mobile_base/velx": xVal,
      "alfred_fvd/teleop_commands/mobile_base/veltheta": yVal,
      "alfred_fvd/teleop_commands/last_command_stamp": DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> teleopManipulation(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.update({
      "alfred_fvd/teleop_commands/manipulator/vel_lift": yVal,
      "alfred_fvd/teleop_commands/manipulator/vel_extend": xVal,
      'alfred_fvd/teleop_commands/last_command_stamp':
          DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> teleopGripper(bool open) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    db.update({
      "alfred_fvd/teleop_commands/manipulator/gripper_open": open,
      'alfred_fvd/teleop_commands/last_command_stamp':
          DateTime.now().millisecondsSinceEpoch/1000.0
    });
  }

  static Future<void> switchModes(bool isAutonomous) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();

    print(isAutonomous);
    if (!isAutonomous) {
      db.update({
        "alfred_fvd/operation_mode": "TELEOPERATION",
      });
    } else {
      db.update({
        "alfred_fvd/operation_mode": "AUTONOMOUS",
      });
    }
  }
}
// robotdisplay