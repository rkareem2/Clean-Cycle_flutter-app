import 'dart:async';
import 'dart:convert';
import 'package:clean_cycle/pages/map_navigation_pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

LatLng calcCenterPoint(LatLng origin, List<LatLng> points) {
  List<double> center = [0, 0];

  if (points.isEmpty) {
    return origin;
  }

  for (int i = 0; i < points.length; i++) {
    center[0] += points[i].latitude;
    center[1] += points[i].longitude;
  }
  center[0] /= points.length;
  center[1] /= points.length;
  return LatLng(center[0], center[1]);
}

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _MyAppState();
}

class _MyAppState extends State<GoogleMapPage> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller = Completer();
  bool _locationGranted = false;
  LatLng _currentLocation = const LatLng(0, 0);
  LatLng _selectedDestination = const LatLng(0, 0);
  Set<Marker> _markers = {};
  bool _previewVisible = false;
  String _selectedLocation = "";
  final Set<Polyline> _polylines = {};
  static const String _placesApiKey = 'AIzaSyCY5gYqBAvY-K2mqvLRitt6eG9wg3kNL5E';

  @override
  void initState() {
    super.initState();
    _getUserLocationAndFetchRecyclingStations();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _locationGranted = false;
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _locationGranted = false;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _locationGranted = true;
    _currentLocation = LatLng(position.latitude, position.longitude);
    _fetchRecyclingStations();
  }

  Future<void> _getUserLocationAndFetchRecyclingStations() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _locationGranted = true;
      _currentLocation = LatLng(position.latitude, position.longitude);
      _fetchRecyclingStations();
    } catch (e) {
      print('Error getting user location: $e');
      print('Attempting to request location.');
      _requestLocationPermission();
    }
  }

  Future<void> _fetchRecyclingStations() async {
    double latitude = _currentLocation.latitude;
    double longitude = _currentLocation.longitude;

    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=5000&type=recycling_center&key=$_placesApiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      setState(() {
        _markers = results.map((place) {
          return Marker(
            markerId: MarkerId(place['place_id']),
            position: LatLng(place['geometry']['location']['lat'],
                place['geometry']['location']['lng']),
            infoWindow: InfoWindow(title: place['name']),
            onTap: () => _previewLocation(
              place['name'],
              LatLng(place['geometry']['location']['lat'],
                  place['geometry']['location']['lng']),
            ),
          );
        }).toSet();
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: calcCenterPoint(_currentLocation,
                _markers.map((marker) => marker.position).toList()),
            tilt: 30,
            zoom: 14.5,
          ),
        ),
      );
    } else {
      print('Failed to fetch recycling stations');
    }
  }

  void _previewLocation(String locationName, LatLng destination) {
    if (_previewVisible) {
      setState(() {
        _selectedLocation = locationName;
        _selectedDestination = destination;
      });
      return;
    } else {
      setState(() {
        _selectedLocation = locationName;
        _selectedDestination = destination;
        _previewVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _locationGranted
          ? Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 15.0,
                  ),
                  markers: _markers,
                  polylines: _polylines,
                  buildingsEnabled: true,
                  compassEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Visibility(
                      visible: _previewVisible,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_selectedLocation,
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _previewVisible = false;
                                      _selectedLocation = "";
                                      _selectedDestination = _currentLocation;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.transparent,
                                    side: const BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    elevation: 0,
                                  ),
                                  icon: const Icon(Icons.cancel_outlined,
                                      color:
                                          Colors.black),
                                  label: const Text('Cancel',
                                      style: TextStyle(
                                          color: Colors.black)),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavigationPage(
                                              locationName: _selectedLocation,
                                              origin: _currentLocation,
                                              destination:
                                                  _selectedDestination)),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.blue,
                                  ),
                                  icon: const Icon(Icons.navigation,
                                      color:
                                          Colors.white),
                                  label: const Text('Start',
                                      style: TextStyle(
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  Center(
                      child: Text("Location Permission Not Granted!",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)),
                  SizedBox(height: 5),
                  Text(
                      "Premissions for user location have been denied, please enable location permissions then try again.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left)
                ],
              )),
    );
  }
}
