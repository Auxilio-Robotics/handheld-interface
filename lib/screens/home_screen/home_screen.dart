import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/agora/actionswidget.dart';
import 'package:frontend/agora/agora_calling.dart';
import 'package:frontend/screens/home_screen/home_call_display.dart';

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
        body: SafeArea(
          child: HomeDisplay(),
          // child:
        ));
  }
}
