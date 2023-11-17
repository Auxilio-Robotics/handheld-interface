import 'package:flutter/material.dart';

class JoyPad extends StatelessWidget {
  Function(double, double) onPressed;
  Function onRelease;
  String heading;
  double valtosend = 0.05;
  JoyPad({super.key, required this.onPressed, required this.onRelease, required this.heading, required this.valtosend});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.red.withAlpha(120),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(heading),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (adf) {
                  onPressed(0, valtosend);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                
                child: CircleAvatar(
                  radius: 20,
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
                  onPressed(valtosend, 0);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                child: CircleAvatar(
                    radius: 20,
                    child: Icon(
                  Icons.arrow_left,
                )),
              ),
              SizedBox(
                width: 50,
              ),
              GestureDetector(
                onTapDown: (adf) {
                  onPressed(-valtosend, 0);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                child: CircleAvatar(
                  radius: 20,
                    child: Icon(
                  Icons.arrow_right,
                )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (adf) {
                  onPressed(0, -valtosend);
                },
                onTapUp: (asdf) {
                  onRelease();
                },
                child: CircleAvatar(
                  radius: 20,
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
