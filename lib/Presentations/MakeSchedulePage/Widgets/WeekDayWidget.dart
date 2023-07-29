import 'package:coursesapp/Presentations/GeneralWidgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekDayWidget extends StatelessWidget {
  const WeekDayWidget({
    Key? key,
    required this.selectedIdx,
    required this.selectedColor,
    required this.unSelectedColor,
    required this.selectedTextColor,
    required this.unSelectedTextColor,
    required this.onTap,
    required this.days,
  }) : super(key: key);
  final List<String> days;
  final int selectedIdx;
  final Color selectedColor;
  final Color unSelectedColor;

  final Color selectedTextColor;
  final Color unSelectedTextColor;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: days.length,
      itemBuilder: (ctx, idx) => GestureDetector(
        onTap: () => onTap(idx),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              days[idx],
              style: TextStyle(
                color: idx == selectedIdx
                    ? selectedTextColor
                    : unSelectedTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        /*Padding(
          padding: EdgeInsets.only(right: 10,left: idx == 0 ? 10 : 0),
          child: CircleAvatar(
            radius: 23,
            backgroundColor: idx == selectedIdx ? selectedColor : unSelectedColor,
            child: ,
          ),
        ),*/
      ),
    );
  }
}
