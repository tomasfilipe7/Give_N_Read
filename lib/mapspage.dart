import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapsPage extends StatefulWidget {
  String destination;
  MapsPage({ Key? key, required this.destination }) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState(destination);
}

class _MapsPageState extends State<MapsPage> {
  String destination;
  _MapsPageState(this.destination);
  GoogleMapController? _mapcontroller;
  final String key = 'AIzaSyAbx2I4dJwjbu3tLNG3WS6tfLzp-UvmcCU';
  
  late Position _currentPosition;


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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _aveiroCity,
                onMapCreated: (controller) => _mapcontroller = controller,
                markers: _createMarker(),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
            ),
          ],
        ),
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

  // markers 
  Marker bookStop1 = Marker(markerId: const MarkerId('markerId1'),
        infoWindow: const InfoWindow(title: 'Book Stop 1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(40.63318631270549, -8.659459114357666));

  Marker bookStop2 = Marker(markerId: const MarkerId('markerId2'),
        infoWindow: const InfoWindow(title: 'Book Stop 2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(40.63067854192939, -8.65347069632065));

  Set<Marker> _createMarker(){
    return{
      bookStop1,
      bookStop2
    };
  }

  // _getCurrentLocation() async{
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
  //     setState(() {
  //       _currentPosition = position;

  //       _mapcontroller?.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(position.latitude, position.longitude),
  //             zoom: 18.0,
  //           )
  //         )
  //       );
  //     });
  //   });
  // }

  @override
  void initState(){
    super.initState();
   // _getCurrentLocation();
  }

  // camera position
  static final LatLng _bStop1 = LatLng(40.63318631270549, -8.659459114357666);
  static final CameraPosition _bStop1Position = CameraPosition(target: _bStop1, zoom: 11.0, tilt: 0, bearing: 0);


  // _initialCameraPosition(String destination) {
  //   print(destination);
  //   if destination == 'center' {
  //     return _aveiroCity;
  //   }
  //   else {
  //     return _bStop1Position;
  //   }
  // }

  // Future<void> _goToBookStop() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_bStop1Position));
  // }

}