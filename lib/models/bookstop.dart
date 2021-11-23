// import 'package:hive/hive.dart';

// part 'bookstop.g.dart';

// @HiveType(typeId: 2)
// class BookStop extends HiveObject{

//   @HiveField(0)
//   late String name;

//   @HiveField(1)
//   late String author;

//   @HiveField(2)
//   late String isbn;

// }

import 'dart:convert';

class BookStop{
  final String id;
  final String books_title;
  final String books_author;

  BookStop(this.id, this.books_title, this.books_author);

  BookStop.fromJson(Map<dynamic, dynamic> json) 
  : id = json['id'] as String,
    books_title = json['books_title'] as String,
    books_author = json['books_author'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'id' : id,
    'books_title' : books_title,
    'books_author' : books_author,
  };
}

