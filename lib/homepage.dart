import 'package:flutter/material.dart';
import 'package:give_n_read/bluetooth_button.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/matches_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            //padding: EdgeInsets.only(top: 60, left: 20, right: 20),
            padding: EdgeInsets.only(right: 120, top: 60),
            child: 
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, shadows: <Shadow>[Shadow(offset: Offset(4.0, 4.0), blurRadius: 8.0, color: Colors.black26)])),
                  Text('Give&Read', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42, color: Theme.of(context).primaryColor, shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 8.0, color: Colors.black26)])),
                ],
              ),
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          // SizedBox(
          //   height: 90,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       Icons.menu_book_rounded,
          //       size: 50,
          //     ),
          //     Text(
          //       "Homepage",
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 30),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 90,
          // ),
          Matches_List(),
          BluetoothButton(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(idx: 0),
    );
  }
}
