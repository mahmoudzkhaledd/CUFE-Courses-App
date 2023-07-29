import 'dart:async';

import 'package:coursesapp/Models/Course.dart';
import 'package:coursesapp/Models/CourseSchedule.dart';
import 'package:coursesapp/Services/CourseServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeSchedulePageController extends GetxController {
  int selectedIdx = 0;
  List<String> days = [
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];
  CourseServices services = CourseServices();
  String chosenCourse = "";
  List<CourseSchedule> courses = [];
  TextEditingController controller = TextEditingController();
  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
  
  CourseSchedule currentCourse = CourseSchedule(
    done: false,
    course: Course(),
    fromTime: CourseTime(0,0,DayPeriod.am),
    toTime: CourseTime(0,0,DayPeriod.pm),
  );
  
  FutureOr<Iterable<Object>> fetchData(TextEditingValue value) async {
    if (value.text.isEmpty) {
      return const Iterable<String>.empty();
    }
    return await services.searchCourse(value.text);
  }
  void addToSchedule(){
    
  }
}
