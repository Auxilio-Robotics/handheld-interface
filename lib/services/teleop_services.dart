import 'package:firebase_database/firebase_database.dart';

abstract class TeleopServices {
  static Future<void> teleopNav(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref("teleop/nav");
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

  static Future<void> teleopGimbal(double x, double y) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    final double xVal = double.parse(x.toStringAsFixed(5));
    final double yVal = double.parse(y.toStringAsFixed(5));
    db.update({
      "teleop/gimbal": {"x": xVal, "y": yVal},
    });
  }
}
