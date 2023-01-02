import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'manipulation_cmd.dart';
import 'navigation_cmd.dart';

class AutonomousCommands extends StatelessWidget {
  final bool isAutoCmd;
  final bool isNavSelected;
  const AutonomousCommands(
      {super.key, required this.isAutoCmd, required this.isNavSelected});

  @override
  Widget build(BuildContext context) {
    if (isAutoCmd) {
      return StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref()
              .child('state/runningAutoCommand')
              .onValue,
          builder: (context, snapshot) {
            bool isRunningCmd = false;
            if (snapshot.hasData) {
              isRunningCmd = snapshot.data!.snapshot.value as bool;
            }
            double screenSize = isRunningCmd ? 300 : 750;
            double screenPadding = 15;
            return Container(
              height: screenSize,
              width: screenSize,
              padding: EdgeInsets.all(screenPadding),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black54,
              ),
              child: isNavSelected
                  ? NavigationCmd(
                      screenPadding: screenPadding,
                      screenSize: screenSize,
                    )
                  : ManipualtionCmd(
                      screenPadding: screenPadding,
                      screenSize: screenSize,
                    ),
            );
          });
    } else {
      return Container();
    }
  }
}
