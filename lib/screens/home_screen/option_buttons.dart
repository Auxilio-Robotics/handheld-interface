import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../widgets/toggle_buttons.dart';

class OptionButtons extends StatelessWidget {
  final bool isNavSelected;
  final bool isAutoCmdSelected;
  final Function onTeleopModeToggled;
  final Function onAutoCommandToggled;

  const OptionButtons({
    super.key,
    required this.isNavSelected,
    required this.isAutoCmdSelected,
    required this.onTeleopModeToggled,
    required this.onAutoCommandToggled,
  });

  /* -------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
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
          return Container(
              /* -------------------------------------------------------------------------- */
              height: MediaQuery.of(context).size.height,
              width: 75,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
              /* -------------------------------------------------------------------------- */
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TouriToggleButtons(
                    isOptionASelected: isAutoCmdSelected,
                    onChanged: () => onAutoCommandToggled(),
                    optionA: Text("A", style: TextStyle(color: Colors.white)),
                    optionB: Text("T", style: TextStyle(color: Colors.white)),
                  ),
                  TouriToggleButtons(
                    isOptionASelected: isNavSelected,
                    onChanged: () => onTeleopModeToggled(),
                    optionA: Text("N", style: TextStyle(color: Colors.white)),
                    optionB: Text("M", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ));
        });
  }
}
