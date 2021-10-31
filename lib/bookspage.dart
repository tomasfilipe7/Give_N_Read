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
      bottomNavigationBar: BottomNavBar(idx: 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: 50,
              ),
              Text(
                "Books page",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Bookslides(
            type: "To Read",
            books: ["Harry Potter", "O Golpe", "Os Maias"],
          ),
          SizedBox(
            height: 10,
          ),
          Bookslides(
            type: "To Give",
            books: [
              "Normal People",
              "A Branca de Neve",
              "Ensaio sobre a cegueira"
            ],
          ),
        ],
      ),
    );
  }
}
