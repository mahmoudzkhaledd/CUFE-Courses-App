import 'package:coursesapp/Models/Course.dart';
import 'package:coursesapp/Models/CourseSchedule.dart';
import 'package:coursesapp/Models/Pair.dart';
import 'package:coursesapp/Networking/HttpHelper.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import '../Database/Database.dart';

class CourseDatabaseServices {
  Database db = AppDataBase.instance;

  Future<int> insertCourse(Course course) async {
    int res = await db.insert(Course.tableName, course.toJson(withId: true));
    return res;
  }

  Future<int> deleteCourse(Course course) async {
    int res = await db.delete(Course.tableName, where: "_id = '${course.id}'");
    return res;
  }

  Future<int> updateCourse(Course course) async {
    int res = await db.update(Course.tableName, course.toJson(withId: true),
        where: "_id = '${course.code}'");
    return res;
  }

  Future<Course?> getCourse(String id) async {
    List<Map<String, dynamic>> res =
        await db.query(Course.tableName, where: "_id = '$id'");

    if (res.isNotEmpty) {
      Course c = Course()..fromJson(res[0]);

      return c;
    }
    return null;
  }

  Future<List<Course>> getAllCourses() async {
    List<Course> courses = [];
    List<Map<String, dynamic>> res = await db.query(Course.tableName);
    for (Map<String, dynamic> mp in res) {
      Course c = Course()..fromJson(mp, data: true);
      courses.add(c);
    }
    return courses;
  }
}

class CourseScheduleDatabaseServices {
  Database db = AppDataBase.instance;

  Future<int> insertCourseSchedule(CourseSchedule course) async {
    int res = await db.insert(CourseSchedule.tableName, course.toJson());
    return res;
  }

  Future<int> deleteCourseSchedule(CourseSchedule course) async {
    int res =
        await db.delete(CourseSchedule.tableName, where: "id = ${course.id}");
    return res;
  }

  Future<int> updateCourseSchedule(CourseSchedule course) async {
    int res = await db.update(CourseSchedule.tableName, course.toJson(),
        where: "id = ${course.id}");
    return res;
  }

  Future<CourseSchedule?> getCourseSchedule(int id) async {
    List<Map<String, dynamic>> res =
        await db.query(CourseSchedule.tableName, where: "id = $id");
    if (res.isNotEmpty) {
      Course? c = await CourseDatabaseServices().getCourse(res[0]['course_id']);
      if (c != null) {
        return CourseSchedule.fromJson(res[0], c);
      } else {
        return null;
      }
    }
    return null;
  }

  Future<List<CourseSchedule>> getAllCoursesSchedule() async {
    List<CourseSchedule> courses = [];
    List<Map<String, dynamic>> res = await db.query(CourseSchedule.tableName);

    for (Map<String, dynamic> mp in res) {
      Course? c = await CourseDatabaseServices().getCourse(mp['course_id']);
      if (c != null) {
        CourseSchedule cs = CourseSchedule.fromJson(mp, c);
        courses.add(cs);
      }
    }
    return courses;
  }
}

class CourseServices {
  Dio dio = HttpHelper.instance;

  Future<Course?> getCourse(String id) async {
    try {
      Response res = await dio.get("find-course/$id");
      if (res.statusCode == 200 && (res.data! as Map).isNotEmpty) {
        return Course()..fromJson(res.data!);
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  Future<Iterable<String>> searchCourse(String nameId) async {
    try {
      Response res = await dio.get('search-course/$nameId');
      if (res.statusCode == 200) {
        List<dynamic> list = res.data! as List<dynamic>;
        return list.map<String>((e) => "${e['code']}-${e['name']}");
      }
    } catch (ex) {
      return [];
    }
    return [];
  }

  Future<Pair<List<Course>, int>> getAllCourses(int page) async {
    try {
      List<Course> courses = [];

      Response res = await dio.get('courses/$page');

      if (res.statusCode != 200 || res.data == null) {
        return Pair([], 0);
      }

      for (var x in res.data['courses']!) {
        courses.add(Course()..fromJson(x));
      }
      return Pair(courses, res.data['count']);
    } catch (err) {
      return Pair([], 0);
    }
  }
}
