import 'package:coursesapp/Controller/CoursePageController.dart';
import 'package:coursesapp/Models/Course.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Shared/Methods.dart';
import 'Widgets/HeroDialogRoute.dart';

class CoursePage extends GetView<CoursePageController> {
  CoursePage({
    Key? key,
    required Course course,
    required this.backColor,
  }) : super(key: key) {
    Get.put(CoursePageController());
    controller.course = course;
  }

  Widget buildFall(bool chk, String title) {
    return Row(
      children: [
        Icon(
          chk ? Icons.check_circle : Icons.close,
        ),
        Text(title),
      ],
    );
  }

  final Color backColor;

  Widget courseInfo(Course course) {
    const double fontSize = 27;
    const FontWeight fw = FontWeight.w600;
    var shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    var color = Color.fromARGB(
        255, backColor.red - 10, backColor.green - 10, backColor.blue - 10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          shape: shape,
          tileColor: color,
          contentPadding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
          leading: const Icon(Icons.subject),
          title: Text(course.isElective ? "Compulsory" : "Elective"),
        ),
        const SizedBox(height: 10),
        ListTile(
          shape: shape,
          tileColor: color,
          contentPadding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
          leading: const Icon(Icons.timer_outlined),
          title: Text("Credit Hours: ${course.creditHours}"),
        ),
        const SizedBox(height: 10),
        ListTile(
            shape: shape,
            tileColor: color,
            contentPadding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
            leading: const Icon(Icons.info_outlined),
            title: Column(
              children: [
                buildFall(course.isFall, "Fall"),
                buildFall(course.isSpring, "Spring"),
                buildFall(course.isSummer, "Summer"),
              ],
            )),
        const SizedBox(height: 10),
        ListTile(
          shape: shape,
          tileColor: color,
          trailing: const Icon(Icons.arrow_forward),
          contentPadding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
          title: const Text("Departments"),
          leading: const Icon(Icons.account_circle_outlined),
          onTap: () {
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Departments"),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: course.departments
                        .map(
                          (e) => Text(
                            e,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursePageController>(
      builder: (ctrl) => Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: backColor,
          title: Text("${ctrl.course.code.toUpperCase()}-${ctrl.course.name}"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              "${ctrl.course.code}\n${ctrl.course.name}",
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Course Prerequisites",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            if (controller.course.preRequisites.isNotEmpty)
              Wrap(
                children: List.generate(
                  ctrl.course.preRequisites.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Chip(
                      onDeleted: () {
                        controller.changeCourse(
                            ctrl.course.preRequisites[index].split(',')[0]);
                      },
                      deleteIcon: const Icon(Icons.arrow_forward_ios_rounded),
                      label: Text(
                        ctrl.course.preRequisites[index].split(',').length == 2
                            ? ctrl.course.preRequisites[index].split(',')[1]
                            : "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              const Center(
                child: Text(
                  "There are no prerequisites of ths course.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            const SizedBox(height: 30),
            courseInfo(ctrl.course),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                    child: SelectableText(
                      ctrl.course.description,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
