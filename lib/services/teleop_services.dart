import 'package:firebase_database/firebase_database.dart';

abstract class FirebaseServices {
  static Future<void> teleopGripperYaw(double x,) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref().child("teleop_commands/manipulator/");
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
      "teleop_commands/manipulator/vel_lift": yVal,
      "teleop_commands/manipulator/vel_extend": xVal,
    });
  }
  
  static Future<void> teleopGripper(bool open) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    db.update({
      "teleop_commands/manipulator/gripper_open": open,
    });
  }


  // static Future<Map<dynamic, dynamic> > getPath(String path) async{
  //   final DatabaseReference db = FirebaseDatabase.instance.ref().child(path);
  //   return db.get().then((value) => value.value);
  // }

  static Future<void> switchModes(bool isAutonomous) async {
    final DatabaseReference db = FirebaseDatabase.instance.ref();
    

    print(isAutonomous);
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