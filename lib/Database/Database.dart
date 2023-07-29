import 'package:coursesapp/Models/Course.dart';
import 'package:coursesapp/Models/CourseSchedule.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDataBase {
  static late Database instance;
  static Future<void> deleteDatabase()async{
    await databaseFactory.deleteDatabase(instance.path);
  }
  static Future<void> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "cufecourses.db");
    instance = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int v) async {
        Batch batch = db.batch();
        batch.execute('''
          create table ${Course.tableName} (
            _id text PRIMARY KEY,
            code text not null,
            name text not null,
            description text not null,
            creditHours INTEGER not null,
            isElective BOOLEAN not null,
            isFall BOOLEAN not null,
            isSpring BOOLEAN not null,
            preRequisites TEXT not null,
            departments TEXT not null
          )
        ''');

        batch.execute('''
          create table ${CourseSchedule.tableName} (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            course_id text,
            hour_from integer not null,
            minute_from integer not null,
            pm_from BOOLEAN not null,
            
            hour_to integer not null,
            minute_to integer not null,
            pm_to BOOLEAN not null,
            
            FOREIGN KEY (course_id) REFERENCES ${Course.tableName} (_id)
          )
        ''');
        await batch.commit();
      },
    );
  }
}
