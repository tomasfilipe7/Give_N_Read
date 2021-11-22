import 'package:flutter/material.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/models/booksgive.dart';
import 'package:give_n_read/models/booksread.dart';
import 'package:give_n_read/newbookpage.dart';
import 'package:hive/hive.dart';

class BooksListAllPage extends StatefulWidget {
  String? type;
  BooksListAllPage({ Key? key, required this.type }) : super(key: key);

  @override
  _BooksListAllPageState createState() => _BooksListAllPageState(type);
}

class _BooksListAllPageState extends State<BooksListAllPage> {
  String? type;
  _BooksListAllPageState(this.type);

  //String image_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNT0xwyLstvC7wH8jYIKur3GTcSq-g6fj2EbL4wk-qaONHYjBswa3rpFsZJeEjuXcG-lw&usqp=CAU";
  
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewBookPage(type: type,)));
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
                setState(() { });
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
                  height: 1000.0,
                  child: ListView.builder(
                    //padding: EdgeInsets.all(20.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: (type == 'To Give' ? (Hive.box<BooksGive>('booksgive').length == 0 ? 0 : Hive.box<BooksGive>('booksgive').length) : (Hive.box<BooksRead>('booksread').length == 0 ? 0 : Hive.box<BooksRead>('booksread').length)) ,
                    itemBuilder: (BuildContext context, int idx) {
                      HiveObject? book = type == 'To Give' ? Hive.box<BooksGive>('booksgive').getAt(idx) : Hive.box<BooksRead>('booksread').getAt(idx);
                      String book_name = type == 'To Give' ? Hive.box<BooksGive>('booksgive').getAt(idx)!.name : Hive.box<BooksRead>('booksread').getAt(idx)!.name;
                      String author = type == 'To Give' ? Hive.box<BooksGive>('booksgive').getAt(idx)!.author : Hive.box<BooksRead>('booksread').getAt(idx)!.author;
                      String? image = type == 'To Give' ? Hive.box<BooksGive>('booksgive').getAt(idx)?.image : Hive.box<BooksRead>('booksread').getAt(idx)?.image;
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
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 7,),
                                          Padding(padding: EdgeInsets.only(right: 20),
                                          child: Text(author,
                                          style: TextStyle(fontSize: 12.0, overflow: TextOverflow.ellipsis,),),),
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
                                  margin: EdgeInsets.only(top: 75.0, left: 210),
                                  child: ElevatedButton(
                                    child: Icon(Icons.delete),
                                    onPressed: () {
                                      //deleteByISBN('[OTHER:UOM:39015050705204]');
                                      showDialog<String>(
                                        context: context, 
                                        builder: (BuildContext context) => AlertDialog(
                                          //title: Text('Delete book'),
                                          content: const Text('Do you want to remove this book?', textAlign: TextAlign.center),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                deleteBook(book);
                                                Navigator.pop(context, 'Yes');
                                                setState(() { });
                                              }, 
                                              child: const Text('Yes'),
                                              style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'No');
                                              }, 
                                              child: const Text('No'),
                                              style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
                                            ),
                                          ],
                                        ),
                                      );
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

void deleteBook(HiveObject? book){
  book?.delete();
}

// void deleteByISBN(String isbn){
//   print(isbn);
//   var filter = Hive.box<BooksGive>('booksgive').values.where((BooksGive) => BooksGive.isbn == isbn).toList();
//   BooksGive book = filter[0];
//   print(book.isbn);
//   book.delete();
// }