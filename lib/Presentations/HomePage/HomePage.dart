import 'package:coursesapp/Controller/HomeScreenController.dart';
import 'package:coursesapp/Presentations/HomePage/Widgets/TodayCourses.dart';
import 'package:coursesapp/Presentations/HomePage/Widgets/TopButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/CourseSchedule.dart';
import '../../Shared/Methods.dart';
import '../AllCoursesPage/AllCoursesPage.dart';
import '../MakeSchedulePage/MakeSchedulePage.dart';
import 'Widgets/MiddleDate.dart';

class HomePage extends GetView<HomeScreenController> {
  HomePage({Key? key}) : super(key: key) {
    Get.put(HomeScreenController());
  }

  Widget title() => Text(
        "My Schedule",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30,
          color: Methods.hexColor("111111"),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          children: [
            const SizedBox(height: 100),
            CustomDrawerIcon(
              text: "All Courses",
              icon: Icons.question_answer_outlined,
              onTap: () {
                Get.to(() => AllCoursesPage());
              },
            ),
            CustomDrawerIcon(
              text: "Make my schedule",
              icon: Icons.table_chart_outlined,
              onTap: () {
                Get.to(() => MakeSchedulePage());
              },
            ),
            CustomDrawerIcon(
              text: "GPA Calculator",
              icon: Icons.calculate_outlined,
              onTap: () {},
            ),
            CustomDrawerIcon(
              text: "About",
              icon: Icons.info_outline_rounded,
              onTap: () {},
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (ctx, isScrolled) => [
          const SliverAppBar(
            title: Text("CUFE Courses"),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(),
                    const SizedBox(height: 20),
                    const TopButtons(),
                    const SizedBox(height: 20),
                    const MiddleDate(),
                  ],
                ),
              ),
              FutureBuilder<List<CourseSchedule>>(
                future: controller.getAllSchedules(),
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    return TodayCourses(courses: snap.data!);
                  } else if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox.square(
                        dimension: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Error has occurred"),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawerIcon extends StatelessWidget {
  const CustomDrawerIcon(
      {Key? key, required this.text, required this.onTap, required this.icon})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(text),
      leading: Icon(icon),
    );
  }
}
