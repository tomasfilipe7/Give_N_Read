import 'package:flutter/material.dart';
import 'package:give_n_read/scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({ Key? key }) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => Scanner(),
                  ),
                );
              }, 
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                fixedSize: Size(200, 50),
                shadowColor: Colors.black, 
                elevation: 6.0,
              ),
              child: const Text(
                'Check-in book',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => Scanner(),
                  ),
                );
              }, 
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                fixedSize: Size(200, 50),
                shadowColor: Colors.black, 
                elevation: 6.0,
              ),
              child: const Text(
                'Check-out book',
                style: TextStyle(fontSize: 20.0),
              )
            ),
          ],
        ),
      ),
    );
  }
}