import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:give_n_read/homepage.dart';
import 'package:give_n_read/models/booksgive.dart';
import 'package:give_n_read/models/booksread.dart';
import 'package:give_n_read/models/bookstop.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
  Hive.registerAdapter(BooksGiveAdapter());
  await Hive.openBox<BooksGive>('booksgive');

  Hive.registerAdapter(BooksReadAdapter());
  await Hive.openBox<BooksRead>('booksread');

  // Hive.registerAdapter(BookStopAdapter());
  // await Hive.openBox<BookStop>('bookstop');

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.teal[300],
        accentColor: Colors.deepOrange.shade300,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: HomePage(),
    );
  }
}
