import 'package:hive/hive.dart';

part 'booksread.g.dart';

@HiveType(typeId: 1)
class BooksRead extends HiveObject{

  @HiveField(0)
  late String name;

  @HiveField(1)
  late String author;

  @HiveField(2)
  late String isbn;

  @HiveField(3)
  late String owner;

  @HiveField(4)
  late String? image;

}