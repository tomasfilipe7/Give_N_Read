import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothButton extends StatefulWidget {
  BluetoothButton({Key? key}) : super(key: key);

  @override
  _BluetoothButtonState createState() => _BluetoothButtonState();
}

class _BluetoothButtonState extends State<BluetoothButton> {
  bool _isScanning = false;
  late BluetoothDevice _connectedDevice;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Updated in the last 5 minutes",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: ScanForDevices,
            child: Icon(
              _isScanning == false
                  ? Icons.bluetooth
                  : Icons.bluetooth_searching_rounded,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(24),
                primary: _isScanning == false
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  void ScanForDevices() {
    setState(() {
      if (_isScanning == true) {
        _isScanning = false;
      } else {
        _isScanning = true;
      }
    });
  }
}
