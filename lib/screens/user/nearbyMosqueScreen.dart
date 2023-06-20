import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/snackbar.dart';

class NearbyMosquePage extends StatefulWidget {
  @override
  _NearbyMosquePageState createState() => _NearbyMosquePageState();
}

class _NearbyMosquePageState extends State<NearbyMosquePage> {
  late GoogleMapController mapController;
  List<Marker> markers = [];
  late Position currentPosition;

  @override
  void initState() {
    super.initState();
    locatePosition();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'You are here'),
        ),
      );
    });
    print(position);
  }
  void locatePosition() async {
    await Geolocator.requestPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition = position;
        LatLng latLngPosition = LatLng(position.latitude, position.longitude);
        CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);
        newGoogleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        updateMarkers(latLngPosition);
        setState(() {
          markers.add(
            Marker(
              markerId: MarkerId('current_location'),
              position: LatLng(position.latitude, position.longitude),
              infoWindow: InfoWindow(title: 'You are here'),
            ),
          );
        });
      } on Exception catch (e) {
        print(e);
      }
    } else {
      await Geolocator.requestPermission();
      alertSnackbar("Location Access Denied");
    }
  }
  Future<List<Mosque>> searchHospitals(LatLng latLng) async {
    ///Enter api key here!!!!!!
    String apiKey = "Enter Your Api Key";
    String baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    String location = '${latLng.latitude},${latLng.longitude}';
    String radius = '1000'; // Search radius in meters
    String type = 'mosque'; // Restrict results to hospitals

    String url =
        '$baseUrl?location=$location&radius=$radius&type=$type&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Mosque> hospitals = [];

      if (data['results'] != null) {
        for (var result in data['results']) {
          String id = result['place_id'];
          String name = result['name'];
          double latitude = result['geometry']['location']['lat'];
          double longitude = result['geometry']['location']['lng'];

          hospitals.add(
            Mosque(
              id: id,
              name: name,
              latitude: latitude,
              longitude: longitude,
            ),
          );
        }
      }

      return hospitals;
    } else {
      throw Exception('Failed to fetch hospitals');
    }
  }

  void updateMarkers(LatLng latLng) async {
    List<Mosque> hospitals = await searchHospitals(latLng);

    setState(() {
      markers.clear();

      markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: latLng,
          infoWindow: InfoWindow(title: 'You are here'),
        ),
      );

      markers.addAll(
        hospitals.map(
              (hospital) => Marker(
            markerId: MarkerId(hospital.id),
            position: LatLng(hospital.latitude, hospital.longitude),
            infoWindow: InfoWindow(title: hospital.name),
          ),
        ),
      );
    });
  }
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        title: Text('Nearby Mosque'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            markers: Set<Marker>.from(markers),
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
              });

              locatePosition();
            },
          ),
        ],
      ),
      // GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(0, 0),
      //   ),
      //   markers: Set<Marker>.from(markers),
      //   onMapCreated: (GoogleMapController controller) {
      //     mapController = controller;
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent.shade700,
        onPressed: () {
          locatePosition();
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}

class Mosque {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Mosque({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}
