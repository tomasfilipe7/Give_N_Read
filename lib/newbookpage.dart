import 'package:flutter/material.dart';
import 'package:give_n_read/bookslistpage.dart';
import 'package:give_n_read/bookspage.dart';

class NewBookPage extends StatefulWidget {
  const NewBookPage({ Key? key }) : super(key: key);

  @override
  _NewBookPageState createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
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
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Author',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor))
                    ),
                    validator: (String? value) {
                      return (value != null) ? 'Please insert the name of the author' : null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ISBN',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor))
                    ),
                    validator: (String? value) {
                      return (value != null) ? 'Please insert the ISBN of the book' : null;
                    },
                  ),
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
                          child: IconButton(onPressed: () => showDialog<String>(
                                              context: context, 
                                              builder: (BuildContext context) => AlertDialog(
                                                title: Text('New book'),
                                                content: const Text('You just added a new book. Thank you!', textAlign: TextAlign.center,),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BooksListPage())), 
                                                    child: const Text('OK'),
                                                    style: TextButton.styleFrom(primary: Theme.of(context).accentColor),
                                                  ),
                                                ],
                                              )
                                            ), 
                                            icon: Icon(Icons.check)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Checking-in...')));
                            }
                          },
                          style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
                          child: IconButton(onPressed: () {Navigator.pop(context); }, icon: Icon(Icons.delete)),
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