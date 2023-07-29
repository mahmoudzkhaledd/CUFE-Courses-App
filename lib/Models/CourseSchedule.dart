import 'package:coursesapp/Models/Course.dart';
import 'package:flutter/material.dart';



class CourseTime {
  late int hour;
  late int minute;
  late DayPeriod afternoon;
  String get timeAsString => "$hour:${minute.toString().padLeft(2,'0')} ${afternoon == DayPeriod.am ? "AM" : "PM"}";
  CourseTime(this.hour,this.minute,this.afternoon);
  CourseTime.fromTimeOfDay(TimeOfDay time):hour = time.hour,minute = time.minute,afternoon = time.period;
  
  String get text {
    int h = hour;
    String period = "AM";
    if(h >= 12) period = "PM";
    if(h > 12) h-= 12;

    return '$h:${minute.toString().padLeft(2, '0')} $period';
  }
  

  int inMinutes() {
    int m = Duration(hours: hour, minutes: minute).inMinutes;
    if (afternoon == DayPeriod.pm) m += const Duration(hours: 12).inMinutes;
    return m;
  }
}

class CourseSchedule {
  static String tableName = "CourseSchedule";
  late int id = 0;
  late bool done;
  late Course course;
  late CourseTime fromTime;
  late CourseTime toTime;
  int type = 0;
  String get differenceTime {
    var d = Duration(minutes:(fromTime.inMinutes() - toTime.inMinutes()).abs());
    final List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }
  CourseSchedule({
    required this.done,
    required this.course,
    required this.fromTime,
    required this.toTime,
  });
  
  Map<String, dynamic> toJson() => {
        "course_id": course.id,
        "hour_from": fromTime.hour,
        "minute_from": fromTime.minute,
        "pm_from": fromTime.afternoon == DayPeriod.pm,
        "hour_to": toTime.hour,
        "minute_to": toTime.minute,
        "pm_to": toTime.afternoon == DayPeriod.pm,
      };

  CourseSchedule.fromJson(Map<String, dynamic> json, Course c) {
    id = json['id'];
    course = c;
    fromTime = CourseTime(json["hour_from"], json["minute_from"],
        json["pm_from"] ? DayPeriod.pm : DayPeriod.am);
    toTime = CourseTime(json["hour_to"], json["minute_to"],
        json["pm_to"] ? DayPeriod.pm : DayPeriod.am);
  }
}
