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
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, top: 55),
            child: Text('Welcome to', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white),),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
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
            padding: EdgeInsets.only(right: 120, left: 20),
            child: 
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text('Welcome to', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, shadows: <Shadow>[Shadow(offset: Offset(4.0, 4.0), blurRadius: 8.0, color: Colors.black26)])),
                  Row(
                    children: [
                      SizedBox(height: 10,),
                      Text('Give', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42, color: Theme.of(context).accentColor, shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 8.0, color: Colors.black26)])),
                      Text('&Read', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42, color: Theme.of(context).primaryColor, shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 8.0, color: Colors.black26)])),
                    ],
                  )
                ],
              ),
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Matches_List(),
          BluetoothButton(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(idx: 0),
    );
  }
}