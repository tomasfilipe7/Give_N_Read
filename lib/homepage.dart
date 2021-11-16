import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:give_n_read/bluetooth_button.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:give_n_read/matches_list.dart';
// import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  // final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  // final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  int matches_found = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _writeController = TextEditingController();
  String message = "GiveU";
  // BluetoothDevice _connectedDevice;
  // late List<BluetoothService> _services;
  late String _connectedDevice;

  _addDeviceTolist(final BluetoothDevice device) {
    // print("ADDING DEVICE");
    // print("Device: ${device.id.toString()}");

    // if (device.type != BluetoothDeviceType.le) {
    //   print(device.type.toString());
    // }
    if (device.address == "A8:30:BC:92:58:2E" ||
        device.address == "48:2C:A0:2F:DB:D1" ||
        device.address == 'A8:30:BC:92:58:2E' ||
        device.address == '48:2C:A0:2F:DB:D1') {
      print("ENCONTREI CARALHO");
      // }
      if (!widget.devicesList.contains(device)) {
        // print("MAC: ");
        // print(device.address.toString());
        setState(() {
          widget.devicesList.add(device);
          widget.matches_found = widget.devicesList.length;
        });
      }
    }
  }

  @override
  void initState() {
    print("##################### IINIIIIT STAAATEEE #####################");
    super.initState();
    FlutterBluetoothSerial.instance.startDiscovery().listen((event) {
      // print(event.device.address +
      //     " " +
      //     event.device.name.toString() +
      //     " " +
      //     event.rssi.toString());
      _addDeviceTolist(event.device);
    });
    // widget.flutterBlue.connectedDevices
    //     .asStream()
    //     .listen((List<BluetoothDevice> devices) {
    //   for (BluetoothDevice device in devices) {
    //     if (device.name != '') {
    //       _addDeviceTolist(device);
    //     }
    //   }
    // });
    // widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
    //   for (ScanResult result in results) {
    //     _addDeviceTolist(result.device);
    //   }
    // });
    // widget.flutterBlue.startScan(scanMode: ScanMode.lowPower);
  }

  // ListView _buildListViewOfDevices() {
  //   List<Container> containers = <Container>[];
  //   for (BluetoothDevice device in widget.devicesList) {
  //     containers.add(
  //       Container(
  //         height: 50,
  //         child: Row(
  //           children: <Widget>[
  //             Expanded(
  //               child: Column(
  //                 children: <Widget>[
  //                   Text(device.name == '' ? '(unknown device)' : device.name),
  //                   Text(device.id.toString()),
  //                 ],
  //               ),
  //             ),
  //             FlatButton(
  //               color: Colors.blue,
  //               child: Text(
  //                 'Connect',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () {},
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }

  //   return ListView(
  //     padding: const EdgeInsets.all(8),
  //     children: <Widget>[
  //       ...containers,
  //     ],
  //   );
  // }

  // List<ButtonTheme> _buildReadWriteNotifyButton(
  //     BluetoothCharacteristic characteristic) {
  //   List<ButtonTheme> buttons = <ButtonTheme>[];

  //   if (characteristic.properties.read) {
  //     buttons.add(
  //       ButtonTheme(
  //         minWidth: 10,
  //         height: 20,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 4),
  //           child: RaisedButton(
  //             color: Colors.blue,
  //             child: Text('READ', style: TextStyle(color: Colors.white)),
  //             onPressed: () async {
  //               var sub = characteristic.value.listen((value) {
  //                 setState(() {
  //                   widget.readValues[characteristic.uuid] = value;
  //                 });
  //               });
  //               await characteristic.read();
  //               sub.cancel();
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   if (characteristic.properties.write) {
  //     buttons.add(
  //       ButtonTheme(
  //         minWidth: 10,
  //         height: 20,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 4),
  //           child: RaisedButton(
  //             child: Text('WRITE', style: TextStyle(color: Colors.white)),
  //             onPressed: () async {
  //               await showDialog(
  //                   context: context,
  //                   builder: (BuildContext context) {
  //                     return AlertDialog(
  //                       title: Text("Write"),
  //                       content: Row(
  //                         children: <Widget>[
  //                           Expanded(
  //                             child: TextField(
  //                               controller: _writeController,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       actions: <Widget>[
  //                         FlatButton(
  //                           child: Text("Send"),
  //                           onPressed: () {
  //                             characteristic.write(
  //                                 utf8.encode(_writeController.value.text));
  //                             Navigator.pop(context);
  //                           },
  //                         ),
  //                         FlatButton(
  //                           child: Text("Cancel"),
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                         ),
  //                       ],
  //                     );
  //                   });
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   if (characteristic.properties.notify) {
  //     buttons.add(
  //       ButtonTheme(
  //         minWidth: 10,
  //         height: 20,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 4),
  //           child: RaisedButton(
  //             child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
  //             onPressed: () async {
  //               characteristic.value.listen((value) {
  //                 widget.readValues[characteristic.uuid] = value;
  //               });
  //               await characteristic.setNotifyValue(true);
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  //   return buttons;
  // }

  // ListView _buildConnectDeviceView() {
  //   List<Container> containers = <Container>[];

  //   for (BluetoothService service in _services) {
  //     List<Widget> characteristicsWidget = <Widget>[];

  //     for (BluetoothCharacteristic characteristic in service.characteristics) {
  //       characteristicsWidget.add(
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Column(
  //             children: <Widget>[
  //               Row(
  //                 children: <Widget>[
  //                   Text(characteristic.uuid.toString(),
  //                       style: TextStyle(fontWeight: FontWeight.bold)),
  //                 ],
  //               ),
  //               Row(
  //                 children: <Widget>[
  //                   ..._buildReadWriteNotifyButton(characteristic),
  //                 ],
  //               ),
  //               Row(
  //                 children: <Widget>[
  //                   Text('Value: ' +
  //                       widget.readValues[characteristic.uuid].toString()),
  //                 ],
  //               ),
  //               Divider(),
  //             ],
  //           ),
  //         ),
  //       );
  //     }
  //     containers.add(
  //       Container(
  //         child: ExpansionTile(
  //             title: Text(service.uuid.toString()),
  //             children: characteristicsWidget),
  //       ),
  //     );
  //   }

  //   return ListView(
  //     padding: const EdgeInsets.all(8),
  //     children: <Widget>[
  //       ...containers,
  //     ],
  //   );
  // }

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
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text('Welcome to', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, shadows: <Shadow>[Shadow(offset: Offset(4.0, 4.0), blurRadius: 8.0, color: Colors.black26)])),
                Row(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(message,
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
                widget.matches_found == 0
                    ? Text(
                        'No matches were found',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        //textAlign: TextAlign.left,
                      )
                    : Text(
                        "You have found ${widget.matches_found} matches",
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
                        itemCount: widget.devicesList.length,
                        itemBuilder: (BuildContext context, int idx) {
                          return GestureDetector(
                            child: Column(
                              children: <Widget>[
                                for (BluetoothDevice device
                                    in widget.devicesList)
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.book_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      Text(
                                        device.name.toString(),
                                        style: const TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Expanded(
                                        child: Text(
                                          device.address,
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      TextButton(
                                          child: Text(
                                            'Connect',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            print(
                                                "################ DEVICE #################");
                                            print(device.bondState.toString());
                                            print(
                                                device.isConnected.toString());
                                            print(device.name.toString());
                                            print(device.address.toString());
                                            print(device.type.toString());
                                            print(device.toString());
                                            try {
                                              BluetoothConnection connection =
                                                  await BluetoothConnection
                                                      .toAddress(
                                                          device.address);
                                              print('Connected to the device');

                                              connection.input!
                                                  .listen((Uint8List data) {
                                                print(
                                                    'Data incoming: ${ascii.decode(data)}');
                                                connection.output
                                                    .add(data); // Sending data

                                                if (ascii
                                                    .decode(data)
                                                    .contains('!')) {
                                                  connection
                                                      .finish(); // Closing connection
                                                  print(
                                                      'Disconnecting by local host');
                                                }
                                              }).onDone(() {
                                                print(
                                                    'Disconnected by remote request');
                                              });
                                            } catch (exception) {
                                              print(
                                                  'Cannot connect, exception occured');
                                              print(exception.toString());
                                            }
                                          }
                                          //async {
                                          //   widget.flutterBlue.stopScan();
                                          //   try {
                                          //     await device.connect();
                                          //   } catch (e) {
                                          //     if (e.toString() !=
                                          //         'already_connected') {
                                          //       throw e;
                                          //     }
                                          //   } finally {
                                          //     print(
                                          //         "####################### SERVICEES ###################");
                                          //     print(device.id.toString());
                                          //     _services =
                                          //         await device.discoverServices();
                                          //     // print("\n#### CHARACTERISTICS #######\n");
                                          //     for (BluetoothService service
                                          //         in _services) {
                                          //       // print(
                                          //       //     "####################### SERVICE ###################");
                                          //       // print(service.toString());
                                          //       // print("\n");
                                          //       // print(
                                          //       //     "CHARACTERISTICS OF ${service.deviceId.toString()}: ");
                                          //       // print("\n");
                                          //       List<Widget>
                                          //           characteristicsWidget =
                                          //           <Widget>[];

                                          //       for (BluetoothCharacteristic characteristic
                                          //           in service.characteristics) {
                                          //         // print(
                                          //         //     "####################### CHARACTERISTICS ###################");
                                          //         // print(characteristic.toString());
                                          //         // print(
                                          //         //     "####################### END CHARACTERISTIC");
                                          //         // print("\n");
                                          //         // print(
                                          //         //     "Device id: ${characteristic.deviceId.toString()}: ");
                                          //         // print("\n");
                                          //         // print(
                                          //         //     "Properties: ${characteristic.properties.toString()}: ");
                                          //         // print("\n");
                                          //         // print(
                                          //         //     "UUid: ${characteristic.uuid.toString()}: ");
                                          //         // print("\n");
                                          //         // print(
                                          //         //     "UUID MAC: ${characteristic.uuid.toMac()}: ");
                                          //         // print("\n");

                                          //         readMessage(characteristic);
                                          //         writeMessage(characteristic,
                                          //             "Hello, I come in peace");
                                          //       }
                                          //       // print(
                                          //       // "####################### END CHARACTERISTICS");
                                          //     }
                                          //   }
                                          //   setState(() {
                                          //     // print(
                                          //     //     "########## SERVICES: ${_services.toString()}");
                                          //     _connectedDevice = device;
                                          //   });
                                          // },
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
          BluetoothButton(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(idx: 0),
    );
  }

  // Future<void> readMessage(BluetoothCharacteristic characteristic) async {
  //   print("################ READING");
  //   if (characteristic.properties.read) {
  //     var sub = characteristic.value.listen((value) {
  //       setState(() {
  //         widget.readValues[characteristic.uuid] = value;
  //         message = value.toString();
  //       });
  //     });
  //     await characteristic.read();
  //     sub.cancel();
  //     print("################ READING COMPLETED");
  //   }
  // }

  // writeMessage(BluetoothCharacteristic characteristic, String text) {
  //   print("################ WRITING");
  //   if (characteristic.properties.write) {
  //     characteristic.write(utf8.encode(text));
  //     Navigator.pop(context);
  //   }
  //   print("################ WRITING COMPLETED");
  // }
}

class Matches_List extends StatefulWidget {
  const Matches_List({Key? key}) : super(key: key);

  @override
  _Matches_ListState createState() => _Matches_ListState();
}

class _Matches_ListState extends State<Matches_List> {
  final book_list = {
    "Harry Potter, ": "J.K.Rowling",
    "Lá, onde o vento não chora, ": "Delia Owens",
    "O Golpe, ": "Robert Muchamore"
  };
  int matches_found = 3;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          matches_found == 0
              ? Text(
                  'No matches were found',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  //textAlign: TextAlign.left,
                )
              : Text(
                  "You have found $matches_found matches",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  //textAlign: TextAlign.left,
                ),
          SizedBox(
            height: 30,
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (final book in book_list.entries)
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.book_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      book.key,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Text(
                        book.value,
                        style: TextStyle(color: Colors.grey[500], fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
