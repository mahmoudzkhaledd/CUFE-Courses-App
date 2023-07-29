import 'package:coursesapp/Shared/Methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MiddleDate extends StatelessWidget {
  const MiddleDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(DateFormat("d.MMMM").format(DateTime.now()),
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          DateFormat('EEEE').format(DateTime.now()),
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.w900,
            color: Methods.hexColor("333333"),
          ),
        ),
      ],
    );
  }
}
