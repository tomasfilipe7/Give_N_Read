import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:give_n_read/bottomnavbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapsPage extends StatefulWidget {
  String destination;
  MapsPage({Key? key, required this.destination}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState(destination);
}

class _MapsPageState extends State<MapsPage> {
  String destination;
  _MapsPageState(this.destination);
  GoogleMapController? _mapcontroller;
  final String key = 'AIzaSyAbx2I4dJwjbu3tLNG3WS6tfLzp-UvmcCU';

  late Position _currentPosition;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  @override
  void dispose() {
    _mapcontroller?.dispose();
    super.dispose();
  }

  static const CameraPosition _aveiroCity = CameraPosition(
    target: LatLng(40.6333308, -8.6499974),
    zoom: 16,
  );

  static final LatLng _bStop1 = LatLng(40.63318631270549, -8.659459114357666);
  static final CameraPosition _bStop1Position =
      CameraPosition(target: _bStop1, zoom: 18.0, tilt: 0, bearing: 0);
  static final LatLng _bStop2 = LatLng(40.63067854192939, -8.65347069632065);
  static final CameraPosition _bStop2Position =
      CameraPosition(target: _bStop2, zoom: 18.0, tilt: 0, bearing: 0);

  @override
  void initState() {
    _getCurrentLocation();
    _getPolyline();
    print('oiii');
    super.initState();
  }

  _initialCameraPosition(String destination) {
    if (destination == 'center') {
      return _aveiroCity;
    } else if (destination == "BookStop1") {
      return _bStop1Position;
    } else {
      return _bStop2Position;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition(destination),
                onMapCreated: (controller) => _mapcontroller = controller,
                markers: _createMarker(),
                polylines: Set<Polyline>.of(polylines.values),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mapcontroller
            ?.animateCamera(CameraUpdate.newCameraPosition(_aveiroCity)),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.center_focus_strong),
      ),
      bottomNavigationBar: const BottomNavBar(idx: 3),
    );
  }

  // markers
  Marker bookStop1 = Marker(
      markerId: const MarkerId('markerId1'),
      infoWindow: const InfoWindow(title: 'Book Stop 1'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      position: LatLng(40.63318631270549, -8.659459114357666));

  Marker bookStop2 = Marker(
      markerId: const MarkerId('markerId2'),
      infoWindow: const InfoWindow(title: 'Book Stop 2'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      position: LatLng(40.63067854192939, -8.65347069632065));

  Set<Marker> _createMarker() {
    return {bookStop1, bookStop2};
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('hello $_currentPosition');
      });
    });
  }

  // void _getLocation() async {
  //   _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   print(_currentPosition);
  // }

  _addPolyline(List<LatLng> routeCoords) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      points: routeCoords,
      width: 11,
    );

    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> routeCoords = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      key,
      PointLatLng(6.849660, 3.648190),
      PointLatLng(6.5212402, 3.3679965),
      travelMode: TravelMode.walking,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        routeCoords.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    _addPolyline(routeCoords);
    print("POLYLINEEEEEEEEEEEE");
  }

  // _createPolylines(
  //   double startLat,
  //   double startLng,
  //   double destLat,
  //   double destLng,
  // ) async {
  //   polylinePoints = PolylinePoints();

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(key, PointLatLng(startLat, startLng), PointLatLng(destLat, destLng), travelMode: TravelMode.walking);

  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoords.add(LatLng(point.latitude, point.longitude));
  //     });
  //   }

  //   PolylineId id = PolylineId('polylineId');

  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.blue,
  //     points: polylineCoords,
  //     width: 3,
  //   );

  //   polylines[id] = polyline;
  // }

  // Future<void> _goToBookStop() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_bStop1Position));
  // }

}
