import 'package:hive/hive.dart';
import 'package:todo_app/Models/dbhelper.dart';

class Boxes {
  static Box<DbHelper> getData() => Hive.box<DbHelper>("todo");
}
