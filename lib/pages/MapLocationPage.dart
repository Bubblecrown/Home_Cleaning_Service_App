// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_cleaning_service_app/shared/ColorScheme.dart';
import 'package:home_cleaning_service_app/pages/Booking.dart';
import 'package:sizer/sizer.dart';

class MapLocationPage extends StatefulWidget {
  const MapLocationPage({Key? key}) : super(key: key);

  @override
  State<MapLocationPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MapLocationPage> {
  GoogleMapController? googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position? position;

  Future<void> getMarkers(double lat, double long, addressLine) async {
    markers.clear();
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow:
            InfoWindow(title: "Your Address", snippet: "${addressLine}"));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  // Future<void> getCurrentLocation() async {
  //   Position currentPosition =
  //       await GeolocatorPlatform.instance.getCurrentPosition();
  //   setState(() {
  //     position = currentPosition;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentLocation();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        leading: BackButton(onPressed: (() {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BookingPage();
          }));
        })),
        backgroundColor: primary,
        elevation: 0,
      ),
      // end appbar

      body: Container(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            onTap: ((tap) async {
              final coordinated =
                  new geo.Coordinates(tap.latitude, tap.longitude);
              var address = await geo.Geocoder.local
                  .findAddressesFromCoordinates(coordinated);
              var firstAddress = address.first;
              getMarkers(tap.latitude, tap.longitude, firstAddress.addressLine);
              await FirebaseFirestore.instance
                  .collection('booking_list')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .set({
                'latitude': tap.latitude,
                'longitude': tap.longitude,
                'Address': firstAddress.addressLine,
              });
            }),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                googleMapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(position?.latitude ?? 13.7563,
                    position?.longitude ?? 100.5018),
                zoom: 15.0),
            markers: Set<Marker>.of(markers.values),
          ),
        ),
      ),
    );
  }
}
