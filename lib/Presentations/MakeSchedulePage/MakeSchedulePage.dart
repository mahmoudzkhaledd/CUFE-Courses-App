import 'dart:async';
import 'package:coursesapp/Models/CourseSchedule.dart';
import 'package:coursesapp/Presentations/GeneralWidgets/CustomButton.dart';
import 'package:coursesapp/Presentations/GeneralWidgets/CustomTextBox.dart';
import 'package:coursesapp/Presentations/MakeSchedulePage/Widgets/ChooseCourse.dart';
import 'package:coursesapp/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/MakeScheduleController.dart';
import '../../Shared/Methods.dart';
import '../GeneralWidgets/RadioButton.dart';
import '../HomePage/Widgets/TimeLine.dart';
import 'Widgets/CustomTimeLine.dart';
import 'Widgets/TimeBox.dart';
import 'Widgets/WeekDayWidget.dart';

class MakeSchedulePage extends GetView<MakeSchedulePageController> {
  MakeSchedulePage({Key? key}) : super(key: key) {
    Get.put(MakeSchedulePageController());
  }

  String getTimeString(int h) {
    if (h == 12) {
      return "12:00 PM";
    }
    if (h >= 13) {
      return "${h - 12}:00 PM";
    }
    return "$h:00 AM";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make your Schedule"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: GetBuilder<MakeSchedulePageController>(
              id: 'DaysCtrl',
              builder: (ctrl) => WeekDayWidget(
                selectedIdx: ctrl.selectedIdx,
                selectedColor: Methods.hexColor("67d867"),
                unSelectedColor: SharedColors.backgroundColor,
                selectedTextColor: Colors.black,
                unSelectedTextColor: Colors.black,
                onTap: (int x) {
                  ctrl.selectedIdx = x;
                  ctrl.update(['DaysCtrl']);
                },
                days: ctrl.days,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                GetBuilder<MakeSchedulePageController>(
                  id: 'choseCourse',
                  builder: (ctrl) => ChooseCourseWidget(
                    fetchData: ctrl.fetchData,
                    chosenCourse: ctrl.chosenCourse,
                    onDeleteCourse: () {
                      ctrl.chosenCourse = "";
                      ctrl.update(['choseCourse']);
                    },
                    onSubmit: (str) {
                      ctrl.chosenCourse = str;
                      ctrl.update(['choseCourse']);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black38),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: GetBuilder<MakeSchedulePageController>(
                    id: 'CourseSchedule',
                    builder: (ctrl) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Course Schedule",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            TimeBox(
                              chosenTime: TimeOfDay(
                                hour: ctrl.currentCourse.fromTime.hour,
                                minute: ctrl.currentCourse.fromTime.minute,
                              ),
                              onTap: (time) {
                                ctrl.currentCourse.fromTime =
                                    CourseTime.fromTimeOfDay(time);
                                ctrl.update(['CourseSchedule']);
                              },
                              title: ctrl.currentCourse.fromTime.text,
                              description: "From",
                            ),
                            const SizedBox(width: 20),
                            TimeBox(
                              chosenTime: TimeOfDay(
                                hour: ctrl.currentCourse.toTime.hour,
                                minute: ctrl.currentCourse.toTime.minute,
                              ),
                              onTap: (time) {
                                ctrl.currentCourse.toTime =
                                    CourseTime.fromTimeOfDay(time);
                                ctrl.update(['CourseSchedule']);
                              },
                              title: ctrl.currentCourse.toTime.text,
                              description: "To",
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            CustomRadioButton<int>(
                              value: 0,
                              text: "Lecture",
                              groupValue: ctrl.currentCourse.type,
                              onChanged: (type) {
                                ctrl.currentCourse.type = type;
                                ctrl.update(['CourseSchedule']);
                              },
                            ),
                            CustomRadioButton<int>(
                              value: 1,
                              text: "Tutorial",
                              groupValue: ctrl.currentCourse.type,
                              onChanged: (type) {
                                ctrl.currentCourse.type = type;
                                ctrl.update(['CourseSchedule']);
                              },
                            ),
                            CustomRadioButton<int>(
                              value: 2,
                              text: "Lab",
                              groupValue: ctrl.currentCourse.type,
                              onChanged: (type) {
                                ctrl.currentCourse.type = type;
                                ctrl.update(['CourseSchedule']);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomTextBox(
                          hintText: "Any Notes",
                          controller: ctrl.controller,
                          multiLine: true,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: ctrl.addToSchedule,
                            child: const Text("OK"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTimeLine(
                  items: [
                    TimeLineItem(
                      from: CourseTime.fromTimeOfDay(
                          TimeOfDay(hour: 7, minute: 0)),
                      to: CourseTime.fromTimeOfDay(
                          TimeOfDay(hour: 8, minute: 0)),
                      text: "Tutorial",
                    ),
                    TimeLineItem(
                      from: CourseTime.fromTimeOfDay(
                          TimeOfDay(hour: 12, minute: 0)),
                      to: CourseTime.fromTimeOfDay(
                          TimeOfDay(hour: 16, minute: 0)),
                      text: "Tutorial",
                    ),
                    TimeLineItem(
                      from: CourseTime.fromTimeOfDay(
                          TimeOfDay(hour: 17, minute: 0)),
                      to: CourseTime.fromTimeOfDay(
                          TimeOfDay(hour: 18, minute: 0)),
                      text: "Tutorial",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
