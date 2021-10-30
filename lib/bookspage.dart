import 'package:flutter/material.dart';
import 'package:give_n_read/bottomNavBar.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({ Key? key }) : super(key: key);

  @override
  _BooksListPageState createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      bottomNavigationBar: BottomNavBar(idx: 1),
    );
  }
}