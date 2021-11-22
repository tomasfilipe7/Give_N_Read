import 'package:flutter/material.dart';
import 'package:give_n_read/bookslistpage.dart';
import 'package:give_n_read/bookspage.dart';
import 'package:books_finder/books_finder.dart';
import 'package:give_n_read/booksresultspage.dart';

class NewBookPage extends StatefulWidget {
  String? type;
  NewBookPage({ Key? key, required this.type }) : super(key: key);

  @override
  _NewBookPageState createState() => _NewBookPageState(type);
}

class _NewBookPageState extends State<NewBookPage> {
  String? type;
  _NewBookPageState(this.type);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController book_name = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: book_name,
                    decoration: InputDecoration(
                      labelText: 'Name of the book',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor))
                    
                    ),
                    validator: (String? value) {
                      return (value != null) ? 'Please insert the name of the book' : null;
                    },
                  ),
                  // SizedBox(height: 15),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Author',
                  //     labelStyle: TextStyle(
                  //       color: Theme.of(context).primaryColor
                  //     ),
                  //     border: OutlineInputBorder(),
                  //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor))
                  //   ),
                  //   validator: (String? value) {
                  //     return (value != null) ? 'Please insert the name of the author' : null;
                  //   },
                  // ),
                  // SizedBox(height: 15),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'ISBN',
                  //     labelStyle: TextStyle(
                  //       color: Theme.of(context).primaryColor
                  //     ),
                  //     border: OutlineInputBorder(),
                  //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor))
                  //   ),
                  //   validator: (String? value) {
                  //     return (value != null) ? 'Please insert the ISBN of the book' : null;
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Checking-in...')));
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                          child: IconButton(
                            onPressed: () async {
                              List<Book> books = await findBooks(book_name.text);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BooksResultsPage(type: type, books: books, scan: false)));
                            },
                            icon: Icon(Icons.check)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Checking-in...')));
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
                          child: IconButton(onPressed: () {Navigator.pop(context); }, icon: Icon(Icons.clear)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Book>> findBooks(String book) async {
  final books = await queryBooks(
    book,
    maxResults: 5,
    printType: PrintType.books,
    orderBy: OrderBy.relevance,
    reschemeImageLinks: true,
  );
  List<Book> booksList = [];
  for (var book in books) {
    //final info = book.info;
    //print('$info\n');
    booksList.add(book);
  }
  return booksList;
}