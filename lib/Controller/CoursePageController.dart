import 'package:coursesapp/Services/CourseServices.dart';
import 'package:coursesapp/Shared/Methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/Course.dart';

class CoursePageController extends GetxController {
  late Course course;
  CourseServices services = CourseServices();

  void changeCourse(String id) async {
    Course? c = await services.getCourse(id);
    if (c != null) {
      course = c;
      update();
    } else {
      Methods.message(Get.context!,"Sorry, The course is not found");
    }
  }
}
