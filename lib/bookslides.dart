import 'package:flutter/material.dart';
import 'package:give_n_read/bookslistpage.dart';
import 'package:give_n_read/bookspage.dart';

class Bookslides extends StatefulWidget {
  String type = "Wanted";
  List<String> books = [""];
  Bookslides({Key? key, required this.type, required this.books})
      : super(key: key);

  @override
  _BookslidesState createState() => _BookslidesState(type, books);
}

class _BookslidesState extends State<Bookslides> {
  String image_url =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNT0xwyLstvC7wH8jYIKur3GTcSq-g6fj2EbL4wk-qaONHYjBswa3rpFsZJeEjuXcG-lw&usqp=CAU";
  List<String> books = ["Harry Potter", "Lá, onde o vento não chora"];
  String type = "Wanted";
  _BookslidesState(this.type, this.books);

  @override
  Widget build(BuildContext context) {
    return Container(
      //physics: BouncingScrollPhysics(),
      child: 
        Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                    shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 8.0, color: Colors.black26)]
                  ),
                  
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BooksListAllPage(type: type, books: books,))),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 270.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (BuildContext context, int idx) {
                String book = books[idx];
                return GestureDetector(
                  child: Container(
                    //margin: EdgeInsets.all(2.0),
                    width: 210.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: 7.5,
                          child: Container(
                            height: 250.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    book,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Padding(
                                    padding: EdgeInsets.only(right: 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 6.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: book,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image(
                                    height: 170.0,
                                    width: 180.0,
                                    image: NetworkImage(image_url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   right: 10.0,
                              //   top: 10.0,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: <Widget>[],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
    );
  }
}