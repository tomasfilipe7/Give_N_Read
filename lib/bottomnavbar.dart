import 'package:flutter/material.dart';
import 'package:give_n_read/bookspage.dart';
import 'package:give_n_read/homepage.dart';
import 'package:give_n_read/mapspage.dart';
import 'package:give_n_read/notificationspage.dart';
import 'package:give_n_read/scanner.dart';


class BottomNavBar extends StatefulWidget {
  final int idx;
  const BottomNavBar({ Key? key, required this.idx}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState(idx: this.idx);
}

class _BottomNavBarState extends State<BottomNavBar> {
  int idx;
  _BottomNavBarState({required this.idx});

  int selectedTab = 0;

  List<Widget> navBarPages = [
    HomePage(),
    BooksListPage(),
    Scanner(),
    MapsPage(destination: 'center'),
    NotificationsPage(),
  ];

  void selectPage(int idx){
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => navBarPages[idx],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 4.0),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: idx == 0 ? Theme.of(context).accentColor : Colors.grey[300], size: 30),
            onPressed: () {
              setState(() {
                selectedTab = 0;
                selectPage(selectedTab);
              });
            },
            padding: EdgeInsets.only(top: 15),
          ),
          IconButton(
            icon: Icon(Icons.library_books, color: idx == 1 ? Theme.of(context).accentColor : Colors.grey[300], size: 30,),
            onPressed: () {
              setState(() {
                selectedTab = 1;
                selectPage(selectedTab);
              });
            },
            padding: EdgeInsets.only(top: 15),
          ),
          IconButton(
            icon: Icon(Icons.camera, color: idx == 2 ? Theme.of(context).accentColor : Theme.of(context).primaryColor, size: 64,),
            onPressed: () {
              setState(() {
                selectedTab = 2;
                selectPage(selectedTab);
              });
            },
            padding: EdgeInsets.only(right: 38, left: 0),
          ),
          IconButton(
            icon: Icon(Icons.location_on, color: idx == 3 ? Theme.of(context).accentColor : Colors.grey[300], size: 30,),
            onPressed: () {
              setState(() {
                selectedTab = 3;
                selectPage(selectedTab);
              });
            },
            padding: EdgeInsets.only(top: 15),
          ),
          IconButton(
            icon: Icon(Icons.notification_add, color: idx == 4 ? Theme.of(context).accentColor : Colors.grey[300], size: 30,),
            onPressed: () {
              setState(() {
                selectedTab = 4;
                selectPage(selectedTab);
              });
            },
            padding: EdgeInsets.only(top: 15),
          )
        ],
      ),
    );
  }
}