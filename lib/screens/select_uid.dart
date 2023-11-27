import 'package:flutter/material.dart';
import '../agora/agora_config.dart' as constants;
import 'dart:math';
class SelectUidScreen extends StatefulWidget {
  @override
  _SelectUidScreenState createState() => _SelectUidScreenState();
}

class _SelectUidScreenState extends State<SelectUidScreen> {
  TextEditingController _textController = TextEditingController();
    Random _random = Random();
  int generateRandomNumber(String seed) {
    int seedHashCode = seed.hashCode;
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    _random = Random(seedHashCode + currentTimeMillis);
    return _random.nextInt(95) + 5; // Generates a random number between 5 and 15
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your name...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Your name:',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String enteredText = _textController.text;
                print("Entered text: $enteredText");
                constants.uid = generateRandomNumber(enteredText);
                print("Uid generated" + constants.uid.toString());
                Navigator.popAndPushNamed(context, '/main');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
