import 'package:coursesapp/Models/CourseSchedule.dart';
import 'package:coursesapp/Services/CourseServices.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  int id = 0;

  CourseDatabaseServices services = CourseDatabaseServices();

  CourseScheduleDatabaseServices courseScheduleServices = CourseScheduleDatabaseServices();
  void addCourse() async {

  }

  Future<List<CourseSchedule>> getAllSchedules() async {
    return await courseScheduleServices.getAllCoursesSchedule();
  }

}
