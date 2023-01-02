import 'package:flutter/material.dart';

const Color selectedColor = Color.fromARGB(136, 255, 0, 0);
const Color unselectedColor = Color.fromARGB(239, 0, 0, 0);

class TouriToggleButtons extends StatelessWidget {
  final bool isOptionASelected;
  final Function onChanged;
  final Widget optionA;
  final Widget optionB;
  const TouriToggleButtons(
      {super.key,
      required this.isOptionASelected,
      required this.onChanged,
      required this.optionA,
      required this.optionB});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Card(
            color: isOptionASelected ? selectedColor : unselectedColor,
            child: TextButton(
              child: optionA,
              onPressed: !isOptionASelected ? () => onChanged() : null,
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 50,
          width: 50,
          child: Card(
            color: !isOptionASelected ? selectedColor : unselectedColor,
            child: TextButton(
              child: optionB,
              onPressed: isOptionASelected ? () => onChanged() : null,
            ),
          ),
        ),
      ],
    );
  }
}
