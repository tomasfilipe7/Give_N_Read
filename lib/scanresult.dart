import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanResult extends StatefulWidget {
  final Barcode? result;
  const ScanResult({ Key? key, required this.result }) : super(key: key);

  @override
  _ScanResultState createState() => _ScanResultState(result: this.result);
}

class _ScanResultState extends State<ScanResult> {
  Barcode? result;
  _ScanResultState({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('${result!.code}'),
    );
  }
}