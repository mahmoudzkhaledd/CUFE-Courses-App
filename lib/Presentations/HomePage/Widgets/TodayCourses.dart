import 'dart:developer';

import 'package:coursesapp/Controller/HomeScreenController.dart';
import 'package:coursesapp/Models/Course.dart';
import 'package:coursesapp/Presentations/HomePage/Widgets/TimeLine.dart';
import 'package:coursesapp/Services/CourseServices.dart';
import 'package:coursesapp/Shared/Colors.dart';
import 'package:coursesapp/Shared/Methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Models/CourseSchedule.dart';
import '../../MakeSchedulePage/MakeSchedulePage.dart';
import 'CourseScheduleWidget.dart';

class TodayCourses extends StatelessWidget {
  TodayCourses({
    Key? key,
    required this.courses,
  }) : super(key: key);
  final List<CourseSchedule> courses;
  HomeScreenController controller = Get.find();

  bool colorFlag = false;

  Color get fontColor {
    return colorFlag ? Methods.hexColor("624719") : Methods.hexColor("4c5657");
  }

  Color get color {
    colorFlag = !colorFlag;
    return colorFlag ? Methods.hexColor("dfb976") : Methods.hexColor("b1bbbc");
  }

  var items = [
    CourseSchedule(
      course: Course()
        ..name = "qwaaaaaaae"
        ..code = "asd",
      fromTime:  CourseTime(12, 55, DayPeriod.pm),
      toTime:  CourseTime(1, 55, DayPeriod.pm),
      done: true,
    ),
    CourseSchedule(
      course: Course()
        ..name = "qwe"
        ..code = "asd",
      fromTime:  CourseTime(1, 30, DayPeriod.pm),
      toTime:  CourseTime(2, 39, DayPeriod.am),
      done: false,
    ),
    CourseSchedule(
      course: Course()
        ..name = "qwe"
        ..code = "asd",
      fromTime:  CourseTime(1, 30, DayPeriod.pm),
      toTime:  CourseTime(2, 39, DayPeriod.am),
      done: false,
    ),
    CourseSchedule(
      course: Course()
        ..name = "qwe"
        ..code = "asd",
      fromTime:  CourseTime(1, 30, DayPeriod.pm),
      toTime:  CourseTime(2, 39, DayPeriod.am),
      done: true,
    ),
    CourseSchedule(
      course: Course()
        ..name = "qwe"
        ..code = "asd",
      fromTime:  CourseTime(1, 30, DayPeriod.pm),
      toTime:  CourseTime(2, 39, DayPeriod.am),
      done: false,
    ),
    CourseSchedule(
      course: Course()
        ..name = "qwe"
        ..code = "asd",
      fromTime: CourseTime(1, 30, DayPeriod.pm),
      toTime: CourseTime(2, 39, DayPeriod.am),
      done: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Methods.hexColor("212535"),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today Courses",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () async {
                  Get.to(() => MakeSchedulePage());
                },
                style: IconButton.styleFrom(
                  backgroundColor: SharedColors.buttonColor,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TimeLine(
            separator: true,
            separatorColor: Colors.white,
            separatorHeight: 110,
            itemCount: items.length,
            builder: (BuildContext context, int idx) => CourseScheduleWidget(
              course: items[idx],
              backColor: idx == 0
                  ? Methods.hexColor("c8f749")
                  : Methods.hexColor("07cbfd"),
              fontColor: Colors.black,
            ),
            iconBuilder: (BuildContext context, int idx) => CircleAvatar(
              backgroundColor: items[idx].done
                  ? Methods.hexColor("68bd95")
                  : Methods.hexColor("dc8536"),
              radius: 17,
              child: Icon(
                items[idx].done ? Icons.check : Icons.access_time_sharp,
                color: Colors.white,
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
