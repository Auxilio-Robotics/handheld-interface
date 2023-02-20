import 'package:flutter/material.dart';
import 'package:frontend/services/teleop_services.dart';
import 'package:frontend/widgets/joypad.dart';
import 'package:frontend/widgets/joystick.dart';


class HomeDisplay extends StatefulWidget {
  const HomeDisplay({super.key});

  @override
  State<HomeDisplay> createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  bool curstate = false; //

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                    elevation: 0, onPressed: () {}, child: Icon(Icons.mic)),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                    elevation: 0,
                    onPressed: () {},
                    child: Icon(Icons.auto_graph_outlined)),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                    elevation: 0, onPressed: () {}, child: Icon(Icons.map)),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //       height: MediaQuery.of(context).size.height,
          //       width: MediaQuery.of(context).size.width,
          //       child: VideoCallDisplay()),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(32.0),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: TeleopJoystick(
          //       onChanged: (stickPos) =>
          //           TeleopServices.teleopManipulation(stickPos.x, stickPos.y),
          //       onRelease: () => TeleopServices.teleopManipulation(0, 0),
          //       label: "Manipulation",
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    curstate = !curstate;
                  });
                  TeleopServices.teleopGripper(curstate);
                  
                },
                backgroundColor:(curstate == true)?Colors.green: Colors.red,
                child: Icon((curstate == false)?Icons.close: Icons.open_in_full ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: JoyPad(
                onPressed: (x, y) {
                  TeleopServices.teleopManipulation(x, y);
                },
                onRelease: () {
                  TeleopServices.teleopManipulation(0, 0);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: TeleopJoystick(
                onChanged: (stickPos) =>
                    TeleopServices.teleopNav(stickPos.x, stickPos.y),
                onRelease: () => TeleopServices.teleopNav(0, 0),
                label: "Navigation",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
