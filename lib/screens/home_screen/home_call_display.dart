import 'package:flutter/material.dart';
// import 'package:frontend/agora/agora_calling.dart';
import 'package:frontend/agora/agora_calling_two.dart';
import 'package:frontend/services/teleop_services.dart';
import 'package:frontend/widgets/joypad.dart';
import 'package:frontend/widgets/joystick.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:frontend/agora/agora_config.dart' as config;
import '../../constants.dart';
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
  double yawval = 180.0;
final AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: config.appId,
        tokenUrl: "https://agora-token-service-production-bad8.up.railway.app",
        channelName: config.channelId,
        uid : config.uid,
      ),
    );

    void initAgora() async {
      await client.initialize();
    }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initAgora();
    

    FirebaseDatabase.instance
        .ref()
        .child("$root/status/operation_mode")
        .get()
        .then((value) {
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context)
          .size
          .width, //MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          (isAutonomous)
              ? Container()
              : Container(
                  child: AgoraVideoViewer(
              layoutType: Layout.oneToOne,
              // floatingLayoutContainerHeight: 150,
              // floatingLayoutContainerWidth:  50,
              client: client
            ),
        
                  color: Colors.black,
                ),
          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
                backgroundColor: isAutonomous ? Colors.teal: Colors.red.withAlpha(200),
                elevation: 0,
                onPressed: () {
                  setState(() {
                    isAutonomous = !isAutonomous;
                  });
                  FirebaseServices.switchModes(isAutonomous);
                },
                child: Text(isAutonomous ? "Auto" : "End")),
          ),
          (!isAutonomous)
              ? Positioned(
                  bottom: 30,
                  child: Container(
                    // color: Colors.green,
                    child: Column(
                      
                      children: [
                        Container(
                          width: 250,
                          height: 180,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Slider(
                                value: yawval,
                                max: 360,
                                divisions: 360,
                                onChanged: (double value) {
                                  FirebaseServices.teleopGripperYaw(value);
                                  setState(() {
                                    yawval = value;
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      curstate = !curstate;
                                    });
                                    FirebaseServices.teleopGripper(curstate);
                                  },
                                  backgroundColor: (curstate == true)
                                      ? Colors.green
                                      : Colors.red,
                                  child: Icon((curstate == false)
                                      ? Icons.close
                                      : Icons.open_in_full),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              JoyPad(
                                heading: "Manipulation",
                                valtosend: 0.1,
                                onPressed: (x, y) {
                                  FirebaseServices.teleopManipulation(x, y);
                                },
                                onRelease: () {
                                  FirebaseServices.teleopManipulation(0, 0);
                                },
                              ),
                              JoyPad(
                                heading: "Navigation",
                                valtosend: 0.2,
                                onPressed: (x, y) {
                                  FirebaseServices.teleopNav(y, x);
                                },
                                onRelease: () {
                                  FirebaseServices.teleopNav(0, 0);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
          (!isAutonomous)
              ? Container()
              : Align(
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
