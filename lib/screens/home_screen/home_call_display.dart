import 'package:flutter/material.dart';
import 'package:frontend/services/teleop_services.dart';
import 'package:frontend/widgets/joystick.dart';
import 'package:frontend/widgets/video_call.dart';

import 'auto_cmd.dart';
import 'joystick_controls.dart';

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
          Align(
            alignment: Alignment.bottomRight,
            child: TeleopJoystick(
              onChanged: (stickPos) =>
                  TeleopServices.teleopManipulation(stickPos.x, stickPos.y),
              onRelease: () => TeleopServices.teleopManipulation(0, 0),
              label: "Manipulation",
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TeleopJoystick(
              onChanged: (stickPos) =>
                  TeleopServices.teleopNav(stickPos.x, stickPos.y),
              onRelease: () => TeleopServices.teleopNav(0, 0),
              label: "Navigation",
            ),
          ),
        ],
      ),
    );
  }
}
