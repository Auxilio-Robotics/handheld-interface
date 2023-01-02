import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class TeleopJoystick extends StatelessWidget {
  final String label;
  final Function(StickDragDetails details) onChanged;
  final Function onRelease;

  const TeleopJoystick({
    Key? key,
    this.label = "",
    required this.onChanged,
    required this.onRelease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withAlpha(200),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (label).toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerUp: (_) => onRelease(),
          child: Joystick(
            listener: (details) => onChanged(details),
            period: const Duration(milliseconds: 100),
          ),
        ),
      ],
    );
  }
}
