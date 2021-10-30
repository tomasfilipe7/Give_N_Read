import 'package:flutter/material.dart';
import 'package:give_n_read/bookspage.dart';
import 'package:give_n_read/homepage.dart';
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
    //HomePage(),
    Scanner(),
    BooksListPage(),
  ];

  void selectPage(int idx){
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => navBarPages[idx],
      ),
    );
    print(selectedTab);
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: idx == 0 ? Theme.of(context).accentColor : Colors.grey[400], size: 34),
            onPressed: () {
              setState(() {
                selectedTab = 0;
                selectPage(selectedTab);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.library_books, color: idx == 1 ? Theme.of(context).accentColor : Colors.grey[400], size: 34,),
            onPressed: () {
              setState(() {
                selectedTab = 1;
                selectPage(selectedTab);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.camera, color: idx == 2 ? Theme.of(context).accentColor : Colors.grey[400], size: 34,),
            onPressed: () {
              setState(() {
                selectedTab = 2;
                selectPage(selectedTab);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.notification_add, color: idx == 3 ? Theme.of(context).accentColor : Colors.grey[400], size: 34,),
            onPressed: () {
              setState(() {
                selectedTab = 3;
                selectPage(selectedTab);
              });
            },
          ),
        ],
      ),
    );
  }
}