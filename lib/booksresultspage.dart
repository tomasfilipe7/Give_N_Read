import 'package:books_finder/books_finder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/boxes.dart';
import 'package:give_n_read/models/booksgive.dart';
import 'package:give_n_read/models/booksread.dart';
import 'package:give_n_read/models/bookstop.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BooksResultsPage extends StatefulWidget {
  String? type;
  List<Book> books;
  bool scan;
  String? bookstop;
  BooksResultsPage(
      {Key? key,
      required this.type,
      required this.books,
      required this.scan,
      required this.bookstop})
      : super(key: key);

  @override
  _BooksResultsPageState createState() =>
      _BooksResultsPageState(type, books, scan, bookstop);
}

class _BooksResultsPageState extends State<BooksResultsPage> {
  //final List<BooksGive> booksGive = [];
  String? type;
  List<Book> books = [];
  bool scan;
  String? bookstop;
  _BooksResultsPageState(this.type, this.books, this.scan, this.bookstop);

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  Uri image_null = Uri.parse(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNT0xwyLstvC7wH8jYIKur3GTcSq-g6fj2EbL4wk-qaONHYjBswa3rpFsZJeEjuXcG-lw&usqp=CAU');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: 900.0,
                  child: ListView.builder(
                    //padding: EdgeInsets.all(20.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: books.length,
                    itemBuilder: (BuildContext context, int idx) {
                      print(books[idx].info.toString());
                      String book = books[idx].info.title;
                      String author = books[idx].info.authors.length == 0 ?  'none' : books[idx].info.authors[0];
                      Uri? image_url =
                          books[idx].info.imageLinks["thumbnail"] == null
                              ? image_null
                              : books[idx].info.imageLinks["thumbnail"];
                      //String image = image_url.toString() == null ? image_url.toString() : image_null;
                      return GestureDetector(
                        child: Container(
                          height: 140.0,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              Positioned(
                                bottom: 10.0,
                                child: Container(
                                  //padding: EdgeInsets.only(top: 0.0),
                                  height: 100.0, // perfect
                                  width: 300.0, // perfect
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 100.0, top: 20, right: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          book,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 40),
                                          child: Text(
                                            author,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40.0, right: 200),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 4.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                        height: 80.0,
                                        width: 70.0,
                                        image: NetworkImage(
                                            (image_url.toString())),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 75.0, left: 210),
                                child: ElevatedButton(
                                    child: Icon(Icons.check),
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          //title: Text('Delete book'),
                                          content: type == 'check-in' ? const Text(
                                              'Do you want to add this book?',
                                              textAlign: TextAlign.center) : const Text(
                                              'Do you want to remove this book?',
                                              textAlign: TextAlign.center),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                if (scan == true) {
                                                  addOrDeleteBooks(
                                                      type,
                                                      books[idx].info.title,
                                                      books[idx]
                                                          .info
                                                          .authors[0],
                                                      books[idx]
                                                          .info
                                                          .industryIdentifier
                                                          .toString(),
                                                      'user1',
                                                      books[idx]
                                                                  .info
                                                                  .imageLinks[
                                                                      "thumbnail"]
                                                                  .toString() ==
                                                              null
                                                          ? image_null
                                                              .toString()
                                                          : books[idx]
                                                              .info
                                                              .imageLinks[
                                                                  "thumbnail"]
                                                              .toString(),
                                                      true,
                                                      bookstop);
                                                } else {
                                                  addOrDeleteBooks(
                                                      type,
                                                      books[idx].info.title,
                                                      books[idx]
                                                          .info
                                                          .authors[0],
                                                      books[idx]
                                                          .info
                                                          .industryIdentifier
                                                          .toString(),
                                                      'user1',
                                                      books[idx]
                                                                  .info
                                                                  .imageLinks[
                                                                      "thumbnail"]
                                                                  .toString() ==
                                                              null
                                                          ? image_null
                                                              .toString()
                                                          : books[idx]
                                                              .info
                                                              .imageLinks[
                                                                  "thumbnail"]
                                                              .toString(),
                                                      false,
                                                      null);
                                                }
                                                Navigator.pop(context, 'Yes');
                                                setState(() {});
                                              },
                                              child: const Text('Yes'),
                                              style: TextButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .accentColor),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'No');
                                              },
                                              child: const Text('No'),
                                              style: TextButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .accentColor),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(idx: 1),
    );
  }
}

Future addOrDeleteBooks(String? type, String name, String author, String isbn,
    String owner, String? image, bool scan, String? bookstop) async {
  print(type);
  final DatabaseReference _bookstopRef =
      FirebaseDatabase.instance.reference().child('bookstop');

  if (scan == true) {
    if (type == 'check-in') {
      // final bookstop = BookStop()
      // ..name = name
      // ..author = author
      // ..isbn = isbn;

      // final box = Boxes.getBookStop();
      // box.add(bookstop);
      // print(box.length);

      _bookstopRef
          .push()
          .set({'id': bookstop, 'books_title': name, 'books_author': author});

      _bookstopRef.once().then((DataSnapshot snapshot) {
        print('Data : ${snapshot.key}');
      });
    } else if (type == 'check-out') {
      // var filter = Hive.box<BookStop>('bookstop').values.where((BookStop) => BookStop.name == name && BookStop.author == author).toList();
      // BookStop book = filter[0];
      // print(book.name);
      // print(book.author);
      // book.delete();
      // print(Hive.box<BookStop>('bookstop').length);

      _bookstopRef.once().then((DataSnapshot snapshot) {
        var map = Map<String, dynamic>.from(snapshot.value);
        map.forEach((key, value) {
          if (value['books_author'] == author &&
              value['books_title'] == name &&
              value['id'] == bookstop) {
            _bookstopRef.child(key).remove();
          }
        });
      });
    }
  } else {
    if (type == 'To Give') {
      final booksgive = BooksGive()
        ..name = name
        ..author = author
        ..isbn = isbn
        ..owner = owner
        ..image = image;

      final box = Boxes.getBooksGive();
      box.add(booksgive);
    } else {
      final booksread = BooksRead()
        ..name = name
        ..author = author
        ..isbn = isbn
        ..owner = owner
        ..image = image;

      final box = Boxes.getBooksRead();
      box.add(booksread);
    }
  }
}
