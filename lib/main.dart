import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/find_robot_screen/find_robot_screen.dart';
import 'package:frontend/screens/home_screen/home_screen.dart';
import 'package:frontend/screens/select_uid.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alfred: Auxilio Robotics',
      theme: ThemeData.dark(),
      
      debugShowCheckedModeBanner: false,
        initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SelectUidScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/main': (context) => Home(),
      },
    );
  }
}
