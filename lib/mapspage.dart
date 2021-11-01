import 'dart:async';

import 'package:flutter/material.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({ Key? key }) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapcontroller;
  
  @override
  void dispose(){
    _mapcontroller?.dispose();
    super.dispose();
  }

  static const CameraPosition _aveiroCity = CameraPosition(
    target: LatLng(40.6333308, -8.6499974),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _aveiroCity,
        onMapCreated: (controller) => _mapcontroller = controller,
        markers: _createMarker(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mapcontroller?.animateCamera(CameraUpdate.newCameraPosition(_aveiroCity)),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.center_focus_strong
        ),
      ),
      bottomNavigationBar: const BottomNavBar(idx: 3),
    );
  }

  Set<Marker> _createMarker(){
    return{
      Marker(
        markerId: const MarkerId('markerId1'),
        infoWindow: const InfoWindow(title: 'Book Stop 1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(40.63318631270549, -8.659459114357666)
      ),
      Marker(
        markerId: const MarkerId('markerId2'),
        infoWindow: const InfoWindow(title: 'Book Stop 2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(40.63067854192939, -8.65347069632065),
      ),
    };
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}