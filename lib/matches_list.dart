import 'package:flutter/material.dart';

class Matches_List extends StatefulWidget {
  const Matches_List({Key? key}) : super(key: key);

  @override
  _Matches_ListState createState() => _Matches_ListState();
}

class _Matches_ListState extends State<Matches_List> {
  int matches_found = 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          matches_found == 0
              ? Text(
                  'No matches were found',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  textAlign: TextAlign.left,
                )
              : Text(
                  "You have found $matches_found matches",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  textAlign: TextAlign.left,
                ),
          SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.book_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Text(
                    "Harry Potter, ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "J.K.Rowling",
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.book_rounded,
                      color: Theme.of(context).colorScheme.secondary),
                  Text("Lá, onde o vento não chora, ",
                      style: TextStyle(fontSize: 18)),
                  Text(
                    "Delia Owens",
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}