import 'package:coursesapp/Database/Database.dart';
import 'package:coursesapp/Networking/HttpHelper.dart';
import 'package:coursesapp/Presentations/HomePage/HomePage.dart';
import 'package:coursesapp/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDataBase.initDB();
  HttpHelper.initDio();
  //await AppDataBase.deleteDatabase();
  runApp(const CoursesApp());
}

class CoursesApp extends StatelessWidget {
  const CoursesApp({super.key});
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: SharedColors.backgroundColor,
          iconTheme: const IconThemeData(
            size: 32,
          ),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: SharedColors.backgroundColor,
      ),
    );
  }
}



