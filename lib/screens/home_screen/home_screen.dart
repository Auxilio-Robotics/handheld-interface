import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/screens/home_screen/home_call_display.dart';
import 'option_buttons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

/* -------------------------------------------------------------------------- */

class _HomeState extends State<Home> {
  // STATE
  bool isNavSelected = false; //1 or 2
  bool isAutoMode = false;

  //BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder(
          stream: FirebaseDatabase.instance.reference().child('state/botMsg').onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String msg = snapshot.data!.snapshot.value.toString();
              if (msg != "None") {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Fluttertoast.showToast(
                    msg: msg,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(130, 0, 0, 0),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  FirebaseDatabase.instance
                      .ref()
                      .child('state')
                      .update({'botMsg': "None"});
                });
              }
            }
            return SafeArea(
              child: HomeDisplay(),
            );
          }),
    );
  }
}


// OptionButtons(
//   isNavSelected: isNavSelected,
//   onTeleopModeToggled: () {
//     setState(() {
//       isNavSelected = !isNavSelected;
//     });
//   },
//   isAutoCmdSelected: isAutoMode,
//   onAutoCommandToggled: () {
//     setState(() {
//       isAutoMode = !isAutoMode;
//     });
//     FirebaseDatabase.instance
//         .ref()
//         .child('state')
//         .update({'teleopMode': !isAutoMode});
//   },
// ),