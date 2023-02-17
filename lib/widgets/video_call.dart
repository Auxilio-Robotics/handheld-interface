// // import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class VideoCallDisplay extends StatefulWidget {
//   const VideoCallDisplay({super.key});

//   @override
//   State<VideoCallDisplay> createState() => _VideoCallWidgetState();
// }

// // 2e1e5e071123495598b48caf4450f1b7

// class _VideoCallWidgetState extends State<VideoCallDisplay> {
// //STATE

//   bool showOtherUsers = true;

// // Instantiate the client
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       appId: "e7c5b65f9465479eb7eda9ce4490c897",
//       channelName: "touri",
//       username: "Prakhar",
//     ),
//   );

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   void initAgora() async {
//     if (client.isInitialized) {
//       await client.engine.leaveChannel();
//     }
//     await client.initialize();
//   }

//   @override
//   void dispose() {
//     client.engine.leaveChannel();
//     print("Leaving channel");
//     super.dispose();
//   }

// // Build your layout
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         children: [
//           ClipRRect(
//             child: AgoraVideoViewer(
//               client: client,
//               layoutType: Layout.floating,
//               floatingLayoutSubViewPadding: EdgeInsets.only(left: 900),
//               floatingLayoutContainerHeight: showOtherUsers ? 200 : 0,
//               floatingLayoutContainerWidth: showOtherUsers ? 200 : 0,
//             ),
//           ),
//           AgoraVideoButtons(
//             client: client,
//             verticalButtonPadding: 20,
//             buttonAlignment: Alignment.bottomCenter,
//             autoHideButtons: false,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ExtraButtons extends StatelessWidget {
//   final IconData icon;
//   final Function onPressed;
//   const ExtraButtons({super.key, required this.icon, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: CircleAvatar(
//         radius: 20,
//         backgroundColor: Color.fromARGB(255, 174, 81, 81),
//         child: IconButton(
//           onPressed: () => onPressed(),
//           icon: Icon(icon, color: Colors.blue),
//         ),
//       ),
//     );
//   }
// }
