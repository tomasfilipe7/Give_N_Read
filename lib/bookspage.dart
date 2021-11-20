import 'package:flutter/material.dart';
import 'package:give_n_read/bookslides.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/models/booksgive.dart';
import 'package:give_n_read/models/booksread.dart';
import 'package:hive/hive.dart';

import 'bluetooth_button.dart';
import 'matches_list.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({Key? key}) : super(key: key);

  @override
  _BooksListPageState createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 55),
              child: Text('Books to Give&Read', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 10,),
                  Bookslides(
                    type: "To Give",
                    books: Hive.box<BooksGive>('booksgive').values.toList(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Bookslides(
                    type: "To Read",
                    books: Hive.box<BooksRead>('booksread').values.toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(idx: 1),
    );
  }
}
