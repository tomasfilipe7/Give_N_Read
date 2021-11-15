import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
import 'package:give_n_read/bottomnavbar.dart';

class BooksResultsPage extends StatefulWidget {
  List<Book> books;
  BooksResultsPage({ Key? key, required this.books }) : super(key: key);

  @override
  _BooksResultsPageState createState() => _BooksResultsPageState(books);
}

class _BooksResultsPageState extends State<BooksResultsPage> {
  List<Book> books = [];
  _BooksResultsPageState(this.books);

  List<Book> books_to_add = [];

  Uri image_null = Uri.parse('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNT0xwyLstvC7wH8jYIKur3GTcSq-g6fj2EbL4wk-qaONHYjBswa3rpFsZJeEjuXcG-lw&usqp=CAU');
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
                child: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
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
                        String book = books[idx].info.title;
                        String author = books[idx].info.authors[0];
                        Uri? image_url = books[idx].info.imageLinks["thumbnail"] == null ? image_null : books[idx].info.imageLinks["thumbnail"];
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
                                      padding: EdgeInsets.only(left: 100.0, top: 20, right: 40),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(book,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 7,),
                                          Text(author),
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
                                          image: NetworkImage((image_url.toString())),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 80.0, left: 200),
                                  child: ElevatedButton(
                                    child: Icon(Icons.check),
                                    onPressed: () {
                                      books_to_add.add(books[idx]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                    )
                                  ),
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