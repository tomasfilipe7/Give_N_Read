import 'package:flutter/material.dart';
import 'package:give_n_read/mapspage.dart';

class NotificationsList extends StatefulWidget {
  List<String> books_titles;
  List<String> bookstops;
  String kek = "kek";
  NotificationsList(
      {required List<String> this.books_titles,
      required List<String> this.bookstops})
      : super();

  @override
  _NotificationsListState createState() =>
      _NotificationsListState(books_titles, bookstops);
}

class _NotificationsListState extends State<NotificationsList> {
  List<String> notifications = <String>[];
  _NotificationsListState(List<String> books_titles, List<String> bookstops) {
    print("INITING NOTIFICATIONS");
    print("KEKU KEKU");
    print("BOOKOS: " + books_titles.toString());
    for (int i = 0; i < books_titles.length; i++) {
      print("ADDING BOOK.");
      print("BOOK TITLE: " + books_titles[i].toString());
      print("BOOK STOPS: " + bookstops[i].toString());
      String notification =
          "🔔 The book ${books_titles[i]} you want to read is now available at ${bookstops[i]}.";
      notifications.add(notification);
    }
    print("FINISHING NOTIFICATIONS");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                      padding: EdgeInsets.only(top: 20, left: 20, right: 30),
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
                              builder: (context) =>
                                  MapsPage(destination: 'bookStop1')));
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
    );
  }
}
