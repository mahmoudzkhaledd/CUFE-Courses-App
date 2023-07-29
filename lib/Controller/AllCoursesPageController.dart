import 'package:coursesapp/Models/Pair.dart';
import 'package:coursesapp/Services/CourseServices.dart';
import 'package:get/get.dart';

import '../Models/Course.dart';

class AllCoursesController extends GetxController {
  CourseServices services = CourseServices();
  int page = 0;
  int count = 0;



  Future<List<Course>> getAllCourses() async {
    Pair<List<Course>,int> courses = await services.getAllCourses(page);
    count = courses.right;
    return courses.left;
  }
}
