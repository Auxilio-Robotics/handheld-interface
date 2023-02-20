// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/services/teleop_services.dart';

// import '../../widgets/joystick.dart';

// class JoyStickControls extends StatelessWidget {
//   final bool isTeleopMode;
//   final bool isNavSelected;
//   const JoyStickControls(
//       {super.key, required this.isTeleopMode, required this.isNavSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           if (isTeleopMode) ...[
//             TeleopJoystick(
//               onChanged: (stickPos) => isNavSelected
//                   ? TeleopServices.teleopNav(stickPos.x, stickPos.y)
//                   : TeleopServices.teleopManipulation(stickPos.x, stickPos.y),
//               onRelease: () => isNavSelected
//                   ? TeleopServices.teleopNav(0, 0)
//                   : TeleopServices.teleopManipulation(0, 0),
//               label: isNavSelected ? "Navigation" : "Manipulation",
//             ),
//             if (isNavSelected) ...[
//               NavigationObjectCloseness()
//             ] else ...[
//               GripperStatus()
//             ]
//           ] else ...[
//             SizedBox(height: 10, width: 10)
//           ],
//           TeleopJoystick(
//             onChanged: (stickPos) =>
//                 TeleopServices.teleopGimbal(stickPos.x, stickPos.y),
//             onRelease: () => TeleopServices.teleopGimbal(0, 0),
//             label: "Gimbal",
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NavigationObjectCloseness extends StatelessWidget {
//   const NavigationObjectCloseness({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseDatabase.instance
//             .ref()
//             .child('state/navObjProximity')
//             .onValue,
//         builder: (context, snapshot) {
//           int top = 0;
//           int bottom = 0;
//           int left = 0;
//           int right = 0;
//           if (snapshot.hasData) {
//             Map proximity = snapshot.data!.snapshot.value as Map;
//             top = top + 80 * proximity['top'] as int;
//             bottom = bottom + 80 * proximity['bottom'] as int;
//             left = left + 80 * proximity['left'] as int;
//             right = right + 80 * proximity['right'] as int;
//           }
//           return ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(30)),
//             child: Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                       color: Color.fromARGB(top, 255, 19, 2), width: 30.0),
//                   bottom: BorderSide(
//                       color: Color.fromARGB(bottom, 255, 19, 2), width: 30.0),
//                   left: BorderSide(
//                       color: Color.fromARGB(left, 255, 19, 2), width: 30.0),
//                   right: BorderSide(
//                       color: Color.fromARGB(right, 255, 19, 2), width: 30.0),
//                 ),
//                 color: Color.fromARGB(142, 0, 0, 0),
//               ),
//             ),
//           );
//         });
//   }
// }

// class GripperStatus extends StatelessWidget {
//   const GripperStatus({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseDatabase.instance
//             .ref()
//             .child('state/gripperClosed')
//             .onValue,
//         builder: (context, snapshot) {
//           bool gripperClosed = false;
//           if (snapshot.hasData) {
//             gripperClosed = snapshot.data!.snapshot.value as bool;
//           }
//           return Container(
//             width: 100,
//             child: TextButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(
//                       Color.fromARGB(255, 199, 195, 194))),
//               onPressed: () {
//                 FirebaseDatabase.instance
//                     .ref()
//                     .child('state')
//                     .update({'gripperClosed': !gripperClosed});
//               },
//               child: Text(
//                 gripperClosed ? 'Ungrasp' : "Grasp",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//           );
//         });
//   }
// }
