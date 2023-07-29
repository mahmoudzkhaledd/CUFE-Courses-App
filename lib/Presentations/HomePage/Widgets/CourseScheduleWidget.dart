import 'package:coursesapp/Models/CourseSchedule.dart';
import 'package:coursesapp/Presentations/GeneralWidgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../Shared/Colors.dart';
import '../../../Shared/Methods.dart';

class CourseScheduleWidget extends StatelessWidget {
  CourseScheduleWidget({
    Key? key,
    required this.course,
    required this.backColor,
    required this.fontColor,
  }) : super(key: key);

  final Color backColor;
  final Color fontColor;
  final CourseSchedule course;

  String time = "";
  bool displayMins = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backColor,
      ),
      //margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "${course.course.code}-${course.course.name}"
                          .capitalizeFirst ??
                      "${course.course.code}-${course.course.name}",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: fontColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: CircleAvatar(
                  backgroundColor: SharedColors.buttonColor,
                  radius: 16,
                  child: Icon(
                    !course.done ? Icons.check : Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: course.fromTime.timeAsString,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: fontColor,
                        ),
                      ),
                      const TextSpan(
                        text: "\nStart",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: SharedColors.buttonColor,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Text(
                      course.differenceTime,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: course.toTime.timeAsString,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: fontColor,
                          ),
                        ),
                        const TextSpan(
                          text: "\nEnd",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
