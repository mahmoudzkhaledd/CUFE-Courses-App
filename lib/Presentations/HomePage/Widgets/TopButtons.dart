import 'package:coursesapp/Shared/Colors.dart';
import 'package:flutter/material.dart';

import '../../GeneralWidgets/CustomButton.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          onTap: () {},
          text: 'Today',
          backColor: SharedColors.buttonColor,
          textColor: Colors.white,
        ),
        const SizedBox(width: 20),
        CustomButton(
          onTap: () {},
          text: 'Calender',
          textColor: SharedColors.buttonColor,
        ),
      ],
    );
  }
}
