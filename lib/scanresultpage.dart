import 'package:books_finder/books_finder.dart';
import 'package:flutter/material.dart';
import 'package:give_n_read/booksresultspage.dart';
import 'package:give_n_read/homepage.dart';
import 'package:give_n_read/scanner.dart';
import 'package:give_n_read/scannerpage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanResult extends StatefulWidget {
  final String? bookStop;
  final String? type;
  const ScanResult({ Key? key, required this.bookStop, required this.type }) : super(key: key);

  @override
  _ScanResultState createState() => _ScanResultState(bookStop: this.bookStop, type: this.type);
}

class _ScanResultState extends State<ScanResult> {
  String? bookStop;
  String? type;
  _ScanResultState({required this.bookStop, required this.type });

  final _formKey = GlobalKey<FormState>();
  TextEditingController book_name = TextEditingController();
  TextEditingController book_isbn = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('You are at ${bookStop}', 
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
            ),
            SizedBox(height: 20),
            Text('Please tell us which book do you want to ',
                  style: const TextStyle(
                      fontSize: 16.0,
                  ),
            ),
            Text('${type}',
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
            ),
            SizedBox(height: 40),
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
                          // child: IconButton(onPressed: () => showDialog<String>(
                          //                     context: context, 
                          //                     builder: (BuildContext context) => AlertDialog(
                          //                       title: Text('${type?.replaceFirst('c', 'C')}' + ' done'),
                          //                       content: const Text('Thank you!', textAlign: TextAlign.center,),
                          //                       actions: <Widget>[
                          //                         TextButton(
                          //                           onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())), 
                          //                           child: const Text('OK'),
                          //                           style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
                          //                         ),
                          //                       ],
                          //                     ),
                            child: IconButton(onPressed: () async {
                                List<Book> books = await findBooks(book_name.text);
                                print(books);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BooksResultsPage(type: type, books: books)));
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
                          child: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner())); }, icon: Icon(Icons.clear)),
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
    print(book);
  }
  return booksList;
}