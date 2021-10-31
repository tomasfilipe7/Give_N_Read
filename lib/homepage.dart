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
      bottomNavigationBar: BottomNavBar(idx: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 90,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: 50,
              ),
              Text(
                "Homepage",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ],
          ),
          SizedBox(
            height: 90,
          ),
          Matches_List(),
          BluetoothButton(),
        ],
      ),
    );
  }
}
