import 'package:flutter/material.dart';

class TimeBox extends StatelessWidget {
  TimeBox({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.chosenTime,
  });
  TimeOfDay chosenTime;
  final Function(TimeOfDay) onTap;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? tmp = await showTimePicker(
          context: context,
          initialTime: chosenTime,
        );
        chosenTime = tmp ?? chosenTime;
        if(tmp != null){
          onTap(tmp);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black38),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
