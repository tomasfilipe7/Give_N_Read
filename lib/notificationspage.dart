import 'package:flutter/material.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/notifications.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({ Key? key }) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

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
              child: Text('Notifications', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white),),
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
              child: NotificationsList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(idx: 4),
    );
  }
}