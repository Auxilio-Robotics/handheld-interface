import 'package:flutter/material.dart';

class JoyPad extends StatelessWidget {
  final Function(double, double) onPressed;
  final Function onRelease;
  const JoyPad({super.key, required this.onPressed, required this.onRelease});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.circular(15)),
      //   color: Colors.black54,
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (adf) {
                  onPressed(0, 0.05);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                
                child: CircleAvatar(
                  radius: 30,
                    child: Icon(
                  Icons.arrow_drop_up,
                )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (adf) {
                  onPressed(0.05, 0);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                child: CircleAvatar(
                    radius: 30,
                    child: Icon(
                  Icons.arrow_left,
                )),
              ),
              SizedBox(
                width: 50,
              ),
              GestureDetector(
                onTapDown: (adf) {
                  onPressed(-0.05, 0);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                child: CircleAvatar(
                  radius: 30,
                    child: Icon(
                  Icons.arrow_left,
                )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (adf) {
                  onPressed(0, -0.05);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                child: CircleAvatar(
                  radius: 30,
                    child: Icon(
                  Icons.arrow_drop_down,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
