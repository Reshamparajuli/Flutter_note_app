import 'package:hive/hive.dart';
part 'dbhelper.g.dart';

@HiveType(typeId: 0)
class DbHelper extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  DbHelper({required this.title, required this.description});
}
