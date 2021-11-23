import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:give_n_read/models/booksgive.dart';
import 'package:give_n_read/models/booksread.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:hive/hive.dart';

import 'bluetooth_button.dart';
import 'bottomnavbar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  int matches_found = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String userName = Random().nextInt(10000).toString();
  final Strategy strategy = Strategy.P2P_STAR;
  Map<String, ConnectionInfo> endpointMap = Map();
  int books_counter = 0;

  String? tempFileUri; //reference to the file currently being transferred
  Map<int, String> map =
      Map(); //store filename mapped to corresponding payloadId
  List<String?> books_title = <String>[];
  Map<String?, String?> books = Map();
  bool _isDiscovering = false;
  bool _isAdvertising = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, top: 55),
            child: Text(
              'Welcome to',
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
            padding: EdgeInsets.only(right: 120, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Give",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 42,
                            color: Theme.of(context).accentColor,
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 8.0,
                                  color: Colors.black26)
                            ])),
                    Text('&Read',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 42,
                            color: Theme.of(context).primaryColor,
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 8.0,
                                  color: Colors.black26)
                            ])),
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                books_title.length == 0
                    ? Text(
                        'No matches were found',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        //textAlign: TextAlign.left,
                      )
                    : Text(
                        "You have found ${books_title.length} matches",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        //textAlign: TextAlign.left,
                      ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 300,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    child: ListView.builder(
                        itemCount: books_title.length,
                        itemBuilder: (BuildContext context, int idx) {
                          return GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.book_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        Text(
                                          books_title[idx].toString(),
                                          style: const TextStyle(fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Text(
                                        books[books_title[idx].toString()]
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        })),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Advertise",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        advertisingButton();
                      },
                      child: Icon(
                        _isAdvertising == false
                            ? Icons.wifi_tethering
                            : Icons.wifi_tethering_off,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(24),
                          primary: _isAdvertising == false
                              ? Colors.grey[300]
                              : Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Discovery",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                discoveringButton();
                              },
                              child: Icon(
                                _isDiscovering == false
                                    ? Icons.connect_without_contact_rounded
                                    : Icons.connect_without_contact_rounded,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(24),
                                  primary: _isDiscovering == false
                                      ? Colors.grey[300]
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ask for books",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                endpointMap.forEach((key, value) {
                                  showSnackbar("Requesting books.");
                                  send_signal(key);
                                });
                              },
                              child: Icon(
                                Icons.multiple_stop_sharp,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(24),
                                  primary: _isDiscovering == false &&
                                          _isAdvertising == false
                                      ? Colors.grey[300]
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    child: Text("Stop All Endpoints"),
                    onPressed: () async {
                      await Nearby().stopAllEndpoints();
                      setState(() {
                        endpointMap.clear();
                      });
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(idx: 0),
    );
  }

  void discoveringButton() async {
    if (_isDiscovering == false) {
      try {
        bool a = await Nearby().startDiscovery(
          userName,
          strategy,
          onEndpointFound: (id, name, serviceId) {
            // show sheet automatically to request connection
            showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text("id: " + id),
                      Text("Name: " + name),
                      Text("ServiceId: " + serviceId),
                      ElevatedButton(
                        child: Text("Request Connection"),
                        onPressed: () {
                          print("REQUEST");
                          Navigator.pop(context);
                          Nearby().requestConnection(
                            userName,
                            id,
                            onConnectionInitiated: (id, info) {
                              onConnectionInit(id, info);
                            },
                            onConnectionResult: (id, status) {
                              showSnackbar(status);
                            },
                            onDisconnected: (id) {
                              setState(() {
                                endpointMap.remove(id);
                              });
                              showSnackbar(
                                  "Disconnected from: ${endpointMap[id]!.endpointName}, id $id");
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          onEndpointLost: (id) {
            showSnackbar(
                "Lost discovered Endpoint: ${endpointMap[id]!.endpointName}, id $id");
          },
        );
        showSnackbar("DISCOVERING");
      } catch (e) {
        showSnackbar(e);
      }
      setState(() {
        _isDiscovering = true;
      });
    } else {
      await Nearby().stopDiscovery();
      setState(() {
        _isDiscovering = false;
      });
    }
  }

  void advertisingButton() async {
    if (_isAdvertising == false) {
      try {
        bool a = await Nearby().startAdvertising(
          userName,
          strategy,
          onConnectionInitiated: onConnectionInit,
          onConnectionResult: (id, status) {
            showSnackbar(status);
          },
          onDisconnected: (id) {
            showSnackbar(
                "Disconnected: ${endpointMap[id]!.endpointName}, id $id");
            setState(() {
              endpointMap.remove(id);
            });
          },
        );
        showSnackbar("ADVERTISING");
      } catch (exception) {
        showSnackbar(exception);
      }
      setState(() {
        _isAdvertising = true;
      });
    } else {
      await Nearby().stopAdvertising();
      setState(() {
        _isAdvertising = false;
      });
    }
  }

  void showSnackbar(dynamic a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a.toString()),
    ));
  }

  Future<bool> moveFile(String uri, String fileName) async {
    String parentDir = (await getExternalStorageDirectory())!.absolute.path;
    final b =
        await Nearby().copyFileAndDeleteOriginal(uri, '$parentDir/$fileName');

    showSnackbar("Moved file:" + b.toString());
    return b;
  }

  void onConnectionInit(String id, ConnectionInfo info) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Center(
          child: Column(
            children: <Widget>[
              Text("id: " + id),
              Text("Token: " + info.authenticationToken),
              Text("Name" + info.endpointName),
              Text("Incoming: " + info.isIncomingConnection.toString()),
              ElevatedButton(
                child: Text("Accept Connection"),
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    endpointMap[id] = info;
                  });
                  Nearby().acceptConnection(
                    id,
                    onPayLoadRecieved: (endid, payload) async {
                      print("RECEIVED SOMETHING");
                      if (payload.type == PayloadType.BYTES) {
                        print("Received BYTES");
                        print(String.fromCharCodes(payload.bytes!));

                        String message = String.fromCharCodes(payload.bytes!);
                        if (message == "send_books") {
                          sendMyReadList(id, info.endpointName);
                        } else {
                          // Decoding
                          Map<String, dynamic> books_to_read =
                              jsonDecode(message);
                          var _book = _Book.fromJson(books_to_read);
                          for (BooksGive book
                              in Hive.box<BooksGive>('booksgive').values) {
                            if (book.name == _book.title &&
                                book.author == _book.author &&
                                !(books.containsKey(_book.title) &&
                                    books.containsValue(_book.author))) {
                              String? book_name = _book.title;
                              String? author = _book.author;
                              String result = "B " + book_name!;

                              setState(() {
                                books_title.add(_book.title);
                                books[_book.title] = _book.author;
                                print("ADDING: " + _book.title.toString());
                                print("BOOK TITLE LENGTH: " +
                                    books_title.length.toString());
                              });
                            }
                          }
                        }

                        if (message.contains(':')) {
                          // used for file payload as file payload is mapped as
                          // payloadId:filename
                          int payloadId = int.parse(message.split(':')[0]);
                          String fileName = (message.split(':')[1]);

                          if (map.containsKey(payloadId)) {
                            if (tempFileUri != null) {
                              moveFile(tempFileUri!, fileName);
                            } else {
                              showSnackbar("File doesn't exist");
                            }
                          } else {
                            //add to map if not already
                            map[payloadId] = fileName;
                          }
                        }
                      } else if (payload.type == PayloadType.FILE) {
                        print("Received FILE");
                        showSnackbar(endid + ": File transfer started");
                        tempFileUri = payload.uri;
                      }
                    },
                    onPayloadTransferUpdate: (endid, payloadTransferUpdate) {
                      if (payloadTransferUpdate.status ==
                          PayloadStatus.IN_PROGRESS) {
                        print(payloadTransferUpdate.bytesTransferred);
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.FAILURE) {
                        print("failed");
                        showSnackbar(endid + ": FAILED to transfer file");
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.SUCCESS) {
                        if (map.containsKey(payloadTransferUpdate.id)) {
                          //rename the file now
                          String name = map[payloadTransferUpdate.id]!;
                          moveFile(tempFileUri!, name);
                        } else {
                          //bytes not received till yet
                          map[payloadTransferUpdate.id] = "";
                        }
                      }
                    },
                  );
                  String accepted =
                      "The device ${info.endpointName} has accepted the connection";
                  Nearby().sendBytesPayload(
                      id, Uint8List.fromList(accepted.codeUnits));
                },
              ),
              ElevatedButton(
                child: Text("Reject Connection"),
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await Nearby().rejectConnection(id);
                  } catch (e) {
                    showSnackbar(e);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    asyncInit();
  }

  void send_signal(id) {
    String signal = "send_books";
    Nearby().sendBytesPayload(id, Uint8List.fromList(signal.codeUnits));
  }

  void sendMyReadList(id, deviceName) {
    // ENCODING
    for (BooksRead book in Hive.box<BooksRead>('booksread').values) {
      _Book _book = _Book(book.name, book.author);
      String _json = jsonEncode(_book);
      showSnackbar("Sending reading list.");
      Nearby().sendBytesPayload(id, Uint8List.fromList(_json.codeUnits));
    }
  }

  void asyncInit() async {
    if (await Nearby().askLocationPermission()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location Permission granted :)")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permissions not granted :(")));
    }
    Nearby().askExternalStoragePermission();
    await Nearby().stopAllEndpoints();
    setState(() {
      endpointMap.clear();
    });
  }
}

class _Book {
  final String? title;
  final String? author;

  _Book(this.title, this.author);

  _Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
      };
}
