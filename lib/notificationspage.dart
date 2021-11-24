import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/models/booksread.dart';
import 'package:give_n_read/notifications.dart';
import 'package:hive/hive.dart';

import 'mapspage.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<String> notifications = <String>[];
  List<String> books_titles = <String>[];
  List<String> bookstops = <String>[];
  final DatabaseReference _bookstopRef =
      FirebaseDatabase.instance.reference().child('bookstop');

  @override
  void initState() {
    asyncInit();
  }

  void asyncInit() async {
    List<String> _notifications = [];
    List<String> _bookstops = [];
    List<BooksRead> books_to_read =
        Hive.box<BooksRead>('booksread').values.toList();
    await _bookstopRef.once().then((DataSnapshot snapshot) {
      var map = Map<String, dynamic>.from(snapshot.value);
      map.forEach((key, value) {
        for (BooksRead book in books_to_read) {
          if (value['books_author'] == book.author &&
              value['books_title'] == book.name) {
            String notification =
                "🔔 The book ${value['books_title']} you want to read is now available at ${value['id']}.";
            _notifications.add(notification);
            _bookstops.add(value['id']);
          }
        }
      });
    });
    setState(() {
      notifications = _notifications;
      bookstops = _bookstops;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 55),
              child: Text(
                'Notifications',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.white),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
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
            Container(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int idx) {
                  String notification = notifications[idx];
                  return GestureDetector(
                    child: Container(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            top: 10,
                            child: Container(
                              height: 150,
                              width: 300,
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
                                //padding: EdgeInsets.only(left: 100.0, top: 20, right: 40),
                                padding: EdgeInsets.only(
                                    top: 20, left: 20, right: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      notification,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 250, top: 8),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 120, top: 100),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapsPage(
                                            destination: bookstops[idx])));
                              },
                              icon: Icon(Icons.directions),
                              label: Text('Take me there!'),
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("Refresh bookstops"),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor),
                onPressed: () {
                  updateBookStops();
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(idx: 4),
    );
  }

  void updateBookStops() async {
    List<String> _notifications = [];
    List<String> _bookstops = [];
    List<BooksRead> books_to_read =
        Hive.box<BooksRead>('booksread').values.toList();
    await _bookstopRef.once().then((DataSnapshot snapshot) {
      var map = Map<String, dynamic>.from(snapshot.value);
      map.forEach((key, value) {
        for (BooksRead book in books_to_read) {
          if (value['books_author'] == book.author &&
              value['books_title'] == book.name) {
            String notification =
                "🔔 The book ${value['books_title']} you want to read is now available at ${value['id']}.";
            _notifications.add(notification);
            _bookstops.add(value['id']);
          }
        }
      });
    });
    setState(() {
      notifications = _notifications;
      bookstops = _bookstops;
    });
  }
}
