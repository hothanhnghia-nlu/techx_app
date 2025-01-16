import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/storeLocation.dart';


class StoreLocationsPage extends StatelessWidget {
  final StoreLocation store;

  const StoreLocationsPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          store.name,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(store.latitude, store.longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId(store.id),
            position: LatLng(store.latitude, store.longitude),
            infoWindow: InfoWindow(
              title: store.name,
              snippet: store.address,
            ),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }
}
