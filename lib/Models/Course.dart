import 'package:flutter/material.dart';

class Course {
  static String tableName = "Courses";

  String id = "";
  String code = "";
  String name = "";
  String description = "";
  int creditHours = 0;
  bool isElective = false;
  bool isFall = false;
  bool isSpring = false;
  bool isSummer = false;
  List<String> preRequisites = [];
  List<String> departments = [];

  void fromJson(Map<String, dynamic> json, {bool data = false}) {

    id = json['_id'];

    code = json['code'];

    name = json['name'];

    description = json['description'];
    creditHours = json['creditHours'];

    isElective = !data ? json['isElective'] : (json['isElective'] == 1);
    isFall = !data ? json['isFall'] : json["isFall"] == 1;
    isSummer = !data ? json['isSummer'] : json["isSummer"] == 1;
    isSpring = !data ? json['isSpring'] : json['isSpring'] == 1;

    if (data) {
      preRequisites = json['preRequisites'].toString().split(',');
    } else {
      preRequisites = List<String>.from(json['preRequisites'] as List);
    }
    if (data) {
      departments = json['departments'].toString().split(',');
    } else {
      departments = List<String>.from(json['departments']as List);
    }
  }

  Map<String, dynamic> toJson({bool withId = false}) => {
        if (withId) "_id": id,
        "code": code,
        "name": name,
        "description": description,
        "creditHours": creditHours,
        "isElective": !withId ? isElective : (isElective ? 1 : 0),
        "isFall": !withId ? isFall : (isFall ? 1 : 0),
        "isSpring": !withId ? isSpring : (isSpring ? 1 : 0),
        "isSummer": !withId ? isSummer : (isSummer ? 1 : 0),
        if (!withId)
          "preRequisites": preRequisites
        else
          "preRequisites": preRequisites.join(','),
        if (!withId)
          "departments": departments
        else
          "departments": departments.join(','),
      };
}
