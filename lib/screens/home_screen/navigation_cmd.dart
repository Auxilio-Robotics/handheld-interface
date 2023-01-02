import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NavigationCmd extends StatelessWidget {
  final double screenSize;
  final double screenPadding;
  const NavigationCmd(
      {super.key, required this.screenSize, required this.screenPadding});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        String? selectedRoom = getSelectedRoom(details);
        if (selectedRoom != null) {
          FirebaseDatabase.instance
              .ref()
              .child('autoSkills/navigation/')
              .update({'selectedRoom': selectedRoom});
        }
      },
      child: Stack(
        children: [
          SizedBox(
            height: screenSize - (2 * screenPadding),
            width: screenSize - (2 * screenPadding),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/touri-65f07.appspot.com/o/navigation_map%2Fnav_map.png?alt=media&token=b405d7f6-5da0-4c15-9dc3-73d96da3e31c",
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('autoSkills/navigation/botPos')
                  .onValue,
              builder: (context, snapshot) {
                double xPos = 0.25;
                double yPos = 0.5;
                if (snapshot.hasData) {
                  Map data = snapshot.data!.snapshot.value as Map;
                  xPos = data['x'].toDouble();
                  yPos = data['y'].toDouble();
                }
                return Align(
                  alignment: Alignment(2 * xPos - 1, 2 * yPos - 1),
                  child: SizedBox(
                    height: screenSize / 5,
                    // width: 100,
                    child: Image.network(
                        "https://hri.cs.uchicago.edu/images/robots/Stretch.png"),
                  ),
                );
              }),
        ],
      ),
    );
  }

  String? getSelectedRoom(TapDownDetails details) {
    String? selectedRoom;
    Map<String, dynamic> roomCoordinates = {
      'gym': {
        'xStart': 0.80417,
        'xEnd': 0.97986,
        'yStart': 0.25764,
        'yEnd': 0.35208,
      },
      'ai_makerspace': {
        'xStart': 0.26181,
        'xEnd': 0.54583,
        'yStart': 0.18681,
        'yEnd': 0.27361,
      },
      'start': {
        'xStart': 0.01250,
        'xEnd': 0.19722,
        'yStart': 0.73194,
        'yEnd': 0.91667,
      },
    };
    final double x =
        details.localPosition.dx / (screenSize - (2 * screenPadding));
    final double y =
        details.localPosition.dy / (screenSize - (2 * screenPadding));

    print("X: ${x.toStringAsFixed(5)}        Y: ${y.toStringAsFixed(5)}");

    roomCoordinates.forEach((room, roomCords) {
      if (roomCords['xEnd'] > x &&
          x > roomCords['xStart'] &&
          roomCords['yEnd'] > y &&
          y > roomCords['yStart']) {
        selectedRoom = room;
      }
    });
    return selectedRoom;
  }
}
