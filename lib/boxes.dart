import 'package:give_n_read/models/booksgive.dart';
import 'package:give_n_read/models/booksread.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<BooksGive> getBooksGive() =>
    Hive.box<BooksGive>('booksgive');

  static Box<BooksRead> getBooksRead() =>
    Hive.box<BooksRead>('booksread');
}