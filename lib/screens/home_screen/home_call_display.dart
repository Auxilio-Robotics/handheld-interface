import 'package:flutter/material.dart';
import 'package:frontend/agora/agora_calling.dart';
import 'package:frontend/services/teleop_services.dart';
import 'package:frontend/widgets/joypad.dart';
import 'package:frontend/widgets/joystick.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeDisplay extends StatefulWidget {
  const HomeDisplay({super.key});

  @override
  State<HomeDisplay> createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  bool curstate = false; //
  bool isAutonomous = false;

  String globalstate = "IDLE";
  String localstate = "IDLE";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance.ref().child("operation_mode").get().then((value) {
      setState(() {
        isAutonomous = (value.value == "AUTONOMOUS");
        print("GOT VALUE FROM FIREBASE = " + value.value.toString());
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("global_state")
        .onValue
        .listen((event) {
      setState(() {
        globalstate = event.snapshot.value.toString();
      });
    });
    FirebaseDatabase.instance
        .ref()
        .child("local_state")
        .onValue
        .listen((event) {
      setState(() {
        globalstate = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          (isAutonomous)
              ? Container()
              : Container(
                  child: JoinChannelVideo(),
                  color: Colors.black,
                ),
          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  setState(() {
                    isAutonomous = !isAutonomous;
                  });
                  FirebaseServices.switchModes(isAutonomous);
                },
                child: Text(isAutonomous ? "Auto" : "Teleop")),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 150,
                height: 50,
                // color: Colors.black.withAlpha(120),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(120),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Text("Robot Metrics",
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "Global State: " + globalstate,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Local State: " + localstate,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    curstate = !curstate;
                  });
                  FirebaseServices.teleopGripper(curstate);
                },
                backgroundColor: (curstate == true) ? Colors.green : Colors.red,
                child: Icon(
                    (curstate == false) ? Icons.close : Icons.open_in_full),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: JoyPad(
                heading : "Manipulation",
                onPressed: (x, y) {
                  FirebaseServices.teleopManipulation(x, y);
                },
                onRelease: () {
                  FirebaseServices.teleopManipulation(0, 0);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: JoyPad(
                heading : "Navigation",
                onPressed: (x, y) {
                  FirebaseServices.teleopNav(x, y);
                },
                onRelease: () {
                  FirebaseServices.teleopNav(0, 0);
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(32.0),
          //   child: Align(
          //     alignment: Alignment.bottomLeft,
          //     child: TeleopJoystick(
          //       onChanged: (stickPos) =>
          //           FirebaseServices.teleopNav(stickPos.x, stickPos.y),
          //       onRelease: () => FirebaseServices.teleopNav(0, 0),
          //       label: "Navigation",
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
