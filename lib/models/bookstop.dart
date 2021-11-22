import 'package:hive/hive.dart';

part 'bookstop.g.dart';

@HiveType(typeId: 2)
class BookStop extends HiveObject{

  @HiveField(0)
  late String name;

  @HiveField(1)
  late String author;

  @HiveField(2)
  late String isbn;

}