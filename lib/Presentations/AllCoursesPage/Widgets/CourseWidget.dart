import 'package:coursesapp/Presentations/CoursePage/CoursePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/Course.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget({
    Key? key,
    required this.course,
    required this.backColor,
  }) : super(key: key);
  final Course course;
  final Color backColor;
  Widget buildCourseData(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>CoursePage(course: course,backColor: backColor));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${course.code.toUpperCase()}-",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: course.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            buildCourseData(Icons.timer_outlined, " Credit Hours: ${course.creditHours}"),
            const SizedBox(height: 10),
            buildCourseData(Icons.info, " [${course.isFall ? " Fall " : ""}${course.isSpring ? " Spring " : ""}${course.isElective ? " Elective " : ""}]"),
          ],
        ),
      ),
    );
  }
}
