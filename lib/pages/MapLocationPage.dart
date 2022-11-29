// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  String? addressLocation;

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(snippet: 'Address'));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  Future getCurrentLocation() async {
    Position currentLocation =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentLocation;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: getCurrentLocation(),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     if (snapshot.data == null) {
    //       return Center(child: CircularProgressIndicator());
    //     }

    //   },
    // );
    return Scaffold(
      // // appbar
      // appBar: AppBar(
      //   leading: BackButton(onPressed: (() {
      //     Navigator.of(context).pop();
      //   })),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // // end appbar

      body: Container(
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: GoogleMap(
            onTap: ((tap) async {
              final coordinated =
                  new geo.Coordinates(tap.latitude, tap.longitude);
              var address = await geo.Geocoder.local
                  .findAddressesFromCoordinates(coordinated);
              var firstAddress = address.first;
              getMarkers(tap.latitude, tap.longitude);
              await FirebaseFirestore.instance.collection('booking_list').add({
                'latitude': tap.latitude,
                'longitude': tap.longitude,
                'Address': firstAddress.addressLine,
              });
              setState(() {
                addressLocation = firstAddress.addressLine;
              });
            }),
            mapType: MapType.hybrid,
            compassEnabled: true,
            trafficEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
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
        // Text('address:${addressLocation}')
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
