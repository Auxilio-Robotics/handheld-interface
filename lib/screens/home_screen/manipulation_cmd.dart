// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class ManipualtionCmd extends StatefulWidget {
//   final double screenSize;
//   final double screenPadding;
//   const ManipualtionCmd(
//       {super.key, required this.screenSize, required this.screenPadding});

//   @override
//   State<ManipualtionCmd> createState() => _ManipualtionCmdState();
// }

// class _ManipualtionCmdState extends State<ManipualtionCmd> {
//   @override
//   void initState() {
//     super.initState();
//     // FirebaseDatabase.instance.ref().child('autoSkills/pickPlace').update({
//     //   'imgRequested': true,
//     //   'imgSrc': "None",
//     //   'tapCordinates': {'x': 0, 'y': 0}
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream:
//           FirebaseDatabase.instance.ref().child('autoSkills/pickPlace').onValue,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           Map pickPlaceStateMap = snapshot.data!.snapshot.value as Map;
//           String imgSrc = pickPlaceStateMap['imgSrc'];
//           bool imgRequested = pickPlaceStateMap['imgRequested'];

//           if (imgRequested) {
//             return imgSrc == "None"
//                 ? Loading()
//                 : PickPlaceImage(
//                     screenSize: widget.screenSize,
//                     screenPadding: widget.screenPadding,
//                     imgSrc: imgSrc,
//                   );
//           } else {
//             return AfterPipelineFinished();
//           }
//         }
//         return Container(
//           color: Colors.orange,
//           height: 50,
//           width: 50,
//         );
//       },
//     );
//   }
// }

// /* ------------------------------- IMG WIDGET ------------------------------- */

// class PickPlaceImage extends StatelessWidget {
//   final double screenSize;
//   final double screenPadding;
//   final String imgSrc;
//   const PickPlaceImage(
//       {super.key,
//       required this.screenSize,
//       required this.screenPadding,
//       required this.imgSrc});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         child: GestureDetector(
//             onTapDown: (TapDownDetails details) {
//               print(details.localPosition.dx);
//               final double x =
//                   details.localPosition.dx / (screenSize - (2 * screenPadding));
//               final double y =
//                   details.localPosition.dy / (screenSize - (2 * screenPadding));
//               FirebaseDatabase.instance
//                   .ref()
//                   .child('autoSkills/pickPlace/tapCordinates')
//                   .update(
//                 {'x': x, 'y': y},
//               );
//             },
//             child: Image.network(imgSrc, fit: BoxFit.fitHeight)),
//       ),
//     );
//   }
// }

// /* ----------------------------- LOADING WIDGET ----------------------------- */

// class Loading extends StatelessWidget {
//   const Loading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(15)),
//       child: Image.network(
//         "https://thumbs.gfycat.com/MistyBleakDrongo-size_restricted.gif",
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }

// class AfterPipelineFinished extends StatelessWidget {
//   const AfterPipelineFinished({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30,
//       width: 50,
//       margin: EdgeInsets.symmetric(horizontal: 200, vertical: 330),
//       child: ElevatedButton(
//         onPressed: () {
//           FirebaseDatabase.instance.ref().child('autoSkills/pickPlace').update({
//             'imgRequested': true,
//             'imgSrc': "None",
//             'tapCordinates': {'x': 0, 'y': 0}
//           });
//         },
//         child: Text('Seach objects to pick up'),
//       ),
//     );
//   }
// }
