import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key,required this.latitude, required this.longitude}) : super(key: key);
  double latitude;
  double longitude;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geolocator = Geolocator();

  double bottomPaddingOfMap =0;
  void locatePosition() async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition,zoom: 14);

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location Sreen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent.shade700,
      ),
      body:SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller){
                _controllerGoogleMap.complete(controller);
                newGoogleMapController=controller;
                locatePosition();
              },
              markers: {
                Marker(
                  markerId: MarkerId("Mosque Location"),
                  position:  LatLng(latitude, longitude),
                  draggable: true,
                  onDragEnd: (value) {

                  },
                  infoWindow: InfoWindow(title: 'Food Location'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(5.0),
                  // To do: custom marker icon
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

