import 'package:flutter/material.dart';
import 'package:give_n_read/bookslides.dart';
import 'package:give_n_read/bottomnavbar.dart';

import 'bluetooth_button.dart';
import 'matches_list.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({Key? key}) : super(key: key);

  @override
  _BooksListPageState createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
          // SizedBox(
          //   height: 70,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.menu_book_rounded,
          //       size: 50,
          //     ),
          //     Text(
          //       "Books page",
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 30),
          //     ),
          //   ],
          // ),
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
                    books: ["Harry Potter", "O Golpe", "Os Maias"],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Bookslides(
                    type: "To Read",
                    books: [
                      "Normal People",
                      "A Branca de Neve",
                      "Ensaio sobre a cegueira"
                    ],
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
