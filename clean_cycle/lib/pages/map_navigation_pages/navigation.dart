import 'dart:async';
import 'dart:convert';
import 'package:clean_cycle/pages/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
// import 'package:location/location.dart';

class NavigationPage extends StatefulWidget {
  final String locationName;
  final LatLng origin;
  final LatLng destination;

  const NavigationPage({super.key, required this.locationName, required this.origin, required this.destination});
  
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late String _locationName;
  late LatLng _origin;
  late LatLng _destination;
  LatLng? _currentP = null;
  // Location _locationController = new Location();
  StreamSubscription<Position>? _positionStreamSubscription;
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Polyline> _polylines = {};
  static const String _directionsApiKey = 'AIzaSyBLjTAuuQcT4AwcDv95tvXiNpeV976B2EE';

  @override
  void initState() {
    super.initState();
    _locationName = widget.locationName;
    _origin = widget.origin;
    _destination = widget.destination;
    _currentP = _origin;

    Timer(const Duration(seconds: 3), () {
      getLocationUpdates().then(
        (_) => _getDirections()
      );
    });
    Timer(const Duration(seconds: 5), () {
      _currentP = LatLng(_origin.latitude + 0.25, _origin.longitude + 0.25);
    });
    
    Timer(const Duration(seconds: 7), () {
      _currentP = LatLng(_origin.latitude + 0.5, _origin.longitude + 0.5);
      print("Time up!");
    });
  }

  Future<void> getLocationUpdates() async {
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;

    // _serviceEnabled = await _locationController.serviceEnabled();
    // if (_serviceEnabled) {
    //   _serviceEnabled = await _locationController.requestService();
    // } else {
    //   return;
    // }

    // _permissionGranted = await _locationController.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await _locationController.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // _locationController.onLocationChanged
    //     .listen((LocationData currentLocation) {
    //   if (currentLocation.latitude != null &&
    //       currentLocation.longitude != null) {
    //     setState(() {
    //       _currentP =
    //           LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //       _cameraToPosition(_currentP!);
    //     });
    //   }
    // });

    // Start listening for location changes
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1, // Minimum distance (in meters) before update
      ),
    ).listen((_) {
      setState(() {
        _cameraToPosition(_currentP!);
      });
    });
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> _getDirections() async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_origin.latitude},${_origin.longitude}&destination=${_destination.latitude},${_destination.longitude}&key=$_directionsApiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
      _setPolyline(encodedPolyline);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  void _setPolyline(String encodedPolyline) {
    List<PointLatLng> points = _decodePolyline(encodedPolyline);
    List<LatLng> latLngPoints = points.map((point) => LatLng(point.latitude, point.longitude)).toList();

    setState(() {
      _polylines.clear();
      _polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: latLngPoints,
        color: Colors.blue,
        width: 5,
      ));
    });
  }

  List<PointLatLng> _decodePolyline(String encoded) {
    List<PointLatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }

    return poly;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
      ),
      body: GoogleMap(
        padding: const EdgeInsets.all(10),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: calcCenterPoint(_origin, [_origin, _destination]),
          zoom: 16,
        ),
        markers: {Marker(
          markerId: const MarkerId('destination'),
          position: _destination,
          infoWindow: InfoWindow(title: _locationName),
        )},
        polylines: _polylines,
        buildingsEnabled: true,
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      )
    );
  }
}
