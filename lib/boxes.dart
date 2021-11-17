import 'package:give_n_read/models/booksgive.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<BooksGive> getBooksGive() =>
    Hive.box<BooksGive>('booksgive');
}