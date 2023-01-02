import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class FindRobotScreen extends StatelessWidget {
  const FindRobotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                "https://i.etsystatic.com/12314924/r/il/866b7c/1488291774/il_1588xN.1488291774_khsx.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.75),
              child: Text(
                'Select a location to continue',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            /* -------------------------------------------------------------------------- */
            TouriOnMap(
              isActive: false,
              location: "Pittsburgh - CMU",
              alignment: Alignment(-0.5, -0.55),
            ),
            TouriOnMap(
              isActive: true,
              location: "India",
              alignment: Alignment(0.42, -0.25),
            ),
            TouriOnMap(
              isActive: false,
              location: "Paris - Louvre",
              alignment: Alignment(0, -0.6),
            ),
            TouriOnMap(
              isActive: true,
              location: "California - Stanford",
              alignment: Alignment(-0.75, -0.4),
            ),
            TouriOnMap(
              isActive: false,
              location: "Sydney",
              alignment: Alignment(0.85, 0.2),
            ),
            TouriOnMap(
              isActive: true,
              location: "South Africa",
              alignment: Alignment(0.1, 0.2),
            ),
            /* -------------------------------------------------------------------------- */
          ],
        ),
      ),
    );
  }
}

class TouriOnMap extends StatelessWidget {
  final bool isActive;
  final String location;
  final Alignment alignment;

  const TouriOnMap(
      {super.key,
      required this.isActive,
      required this.location,
      required this.alignment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      },
      child: Align(
        alignment: alignment,
        child: SizedBox(
          height: 100,
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 70,
                child: Image.network(
                  "https://hri.cs.uchicago.edu/images/robots/Stretch.png",
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: !isActive
                      ? Color.fromARGB(255, 0, 255, 51)
                      : Color.fromARGB(255, 255, 0, 0),
                ),
                child: Text(
                  location,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
