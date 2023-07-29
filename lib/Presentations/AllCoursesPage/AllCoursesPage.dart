import 'package:coursesapp/Controller/AllCoursesPageController.dart';
import 'package:coursesapp/Models/Course.dart';
import 'package:coursesapp/Presentations/AllCoursesPage/Widgets/CourseWidget.dart';

import 'package:coursesapp/Shared/Methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCoursesPage extends GetView<AllCoursesController> {
  AllCoursesPage({Key? key}) : super(key: key) {
    Get.put(AllCoursesController());
  }

  final List<Color> colors = [
    Methods.hexColor("e4b875"),
    Methods.hexColor("fef970"),
  ];
  int idx = 0;

  Color get currectColor {
    if (idx >= colors.length) idx = 0;
    Color c = colors[idx];
    idx++;
    return c;
  }

  Widget pageWidget(int idx) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          if (controller.page != idx - 1) {
            controller.page = idx - 1;
            controller.update();
          }
        },
        child: CircleAvatar(
          radius: 17,
          backgroundColor:
              (controller.page + 1) == idx ? Colors.blue : Colors.white,
          child: Center(child: Text(idx.toString())),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Courses"),
      ),
      body: GetBuilder<AllCoursesController>(
        builder: (ctrl) => FutureBuilder<List<Course>>(
          future: ctrl.getAllCourses(),
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snap.hasData) {
              if (snap.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No Courses added yet, Please Come later.",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ctrl.update();
                        },
                        child: const Text("Refresh"),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  ctrl.update();
                },
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    ...List.generate(
                      snap.data!.length,
                      (index) => CourseWidget(
                        course: snap.data![index],
                        backColor: currectColor,
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            (controller.count / 20).ceil(),
                            (index) => pageWidget(index + 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Error, Please Check Internet Connection.",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ctrl.update();
                      },
                      child: const Text("Refresh"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
