import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:give_n_read/scanresultpage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:url_launcher/url_launcher.dart';

class Scanner extends StatefulWidget {
  const Scanner({ Key? key }) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  var arr;
  String? bookStop;
  String? type;

  @override
  void reassemble(){
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: _buildQRView(context)),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 20),
          SizedBox(
            child: ElevatedButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: FutureBuilder(
                      future: controller?.getFlashStatus(),
                      builder: (context, snapshot) {
                        // return Text('Flash: ${snapshot.data}');
                        return Icon('${snapshot.data}' == 'false' ? Icons.flash_off : Icons.flash_on);
                      },
                    ),
                  ),
              width: 80,
              height: 50,
          ),
          SizedBox(width: 20),
          SizedBox(
            child: ElevatedButton(
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: FutureBuilder(
                      future: controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Icon(Icons.autorenew);
                        } else {
                          return Text('loading');
                        }
                      },
                    ),
                  ),
            width: 80,
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildQRView(BuildContext context){
    var scanArea = (MediaQuery.of(context).size.width < 400 || 
                    MediaQuery.of(context).size.height < 400)
                    ? 250.0
                    : 400.0;

    return QRView(
      key: qrKey, 
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10.0,
        borderLength: 30.0,
        borderWidth: 10.0,
        cutOutSize: scanArea
      ),
    );
  }


  void _onQRViewCreated(QRViewController controller){
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) { 
      controller.pauseCamera();
      setState(() {
        result = scanData;
        arr = result!.code.split(',');
        bookStop = arr[0];
        type = arr[1];
        type = type!.replaceAll(' ', '');
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => ScanResult(bookStop: bookStop, type: type),
          ),
        );
      });
    });
  }
}
