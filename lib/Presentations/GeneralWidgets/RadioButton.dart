import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String text;
  final T value;
  final T groupValue;
  final Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          activeColor: Colors.black,
          value: value,
          groupValue: groupValue,
          onChanged: (type) {
            if (type != null) {
              onChanged(type);
            }
          },
        ),
        Text(text),
      ],
    );
  }
}
