// lib/pages/store/store_locations_page.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/storeLocation.dart';


class StoreLocationsPage extends StatefulWidget {
  const StoreLocationsPage({super.key});

  @override
  State<StoreLocationsPage> createState() => _StoreLocationsPageState();
}

class _StoreLocationsPageState extends State<StoreLocationsPage> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _isMapReady = false;

  // Danh sách cửa hàng mẫu
  final List<StoreLocation> stores = [
    StoreLocation(
      id: '1',
      name: 'TechX Store Hải Dương',
      address: 'Số 82-84 phố Phạm Ngũ Lão, phường Phạm Ngũ Lão, Tp. Hải Dương',
      latitude: 20.9373,
      longitude: 106.3147,
      phone: '0220 3897183',
      workingHours: 'Thứ 2-6: 7:30-17:00\nThứ 7: 7:30-11:30',
    ),
    // Thêm các cửa hàng khác vào đây
  ];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _initializeMap();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
  }

  Future<void> _initializeMap() async {
    for (var store in stores) {
      _markers.add(
        Marker(
          markerId: MarkerId(store.id),
          position: LatLng(store.latitude, store.longitude),
          infoWindow: InfoWindow(
            title: store.name,
            snippet: store.address,
          ),
          onTap: () => _showStoreDetails(store),
        ),
      );
    }
    setState(() {}); // Cập nhật UI với markers mới
  }

  void _showStoreDetails(StoreLocation store) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              store.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 8),
                Expanded(child: Text(store.address)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8),
                Text(store.workingHours),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 8),
                Text(store.phone),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _openGoogleMapsNavigation(
                  LatLng(store.latitude, store.longitude),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Chỉ đường',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openGoogleMapsNavigation(LatLng destination) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}';
    // Thêm xử lý mở URL ở đây (cần thêm package url_launcher)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vị trí cửa hàng',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(stores[0].latitude, stores[0].longitude),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _mapController = controller;
                _isMapReady = true;
              });
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
          ),
          if (!_isMapReady)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}