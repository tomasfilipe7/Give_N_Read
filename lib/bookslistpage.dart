import 'package:flutter/material.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/models/booksgive.dart';
import 'package:give_n_read/newbookpage.dart';
import 'package:hive/hive.dart';

class BooksListAllPage extends StatefulWidget {
  String? type;
  List<String> books;
  BooksListAllPage({ Key? key, required this.type, required this.books }) : super(key: key);

  @override
  _BooksListAllPageState createState() => _BooksListAllPageState(type, books);
}

class _BooksListAllPageState extends State<BooksListAllPage> {
  String? type;
  List<String> books = [];
  _BooksListAllPageState(this.type, this.books);

  //String image_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNT0xwyLstvC7wH8jYIKur3GTcSq-g6fj2EbL4wk-qaONHYjBswa3rpFsZJeEjuXcG-lw&usqp=CAU";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewBookPage()));
            },
            icon: const Icon(Icons.add, color: Colors.white,),
            label: Text('Add new book', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 40),
                child: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left:50, bottom: 0),
            child: Text('List of books ${type}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: 600.0,
                  child: ListView.builder(
                    //padding: EdgeInsets.all(20.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: Hive.box<BooksGive>('booksgive').length,
                    itemBuilder: (BuildContext context, int idx) {
                      String book_name = Hive.box<BooksGive>('booksgive').getAt(idx)!.name;
                      String author = Hive.box<BooksGive>('booksgive').getAt(idx)!.author;
                      String isbn = Hive.box<BooksGive>('booksgive').getAt(idx)!.isbn;
                      String? image = Hive.box<BooksGive>('booksgive').getAt(idx)?.image;
                      String user = Hive.box<BooksGive>('booksgive').getAt(idx)!.owner;
                      print(book_name);
                      print(image);
                      print(isbn);
                      print(author);
                      print(user);
                        //String book = books[idx];
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
                                          Text(book_name,
                                            style: TextStyle(
                                              fontSize: 15.0,
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
                                          image: NetworkImage((image).toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 80.0, left: 200),
                                  child: ElevatedButton(
                                    child: Icon(Icons.delete),
                                    onPressed: () {},
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