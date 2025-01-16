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
            onTap: () {
              // Hiển thị thông tin chi tiết cửa hàng khi nhấn vào Marker
              showModalBottomSheet(
                context: context,
                builder: (context) => _buildStoreDetails(context),
              );
            },
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }

  // Hàm xây dựng giao diện chi tiết cửa hàng
  Widget _buildStoreDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  store.address,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                store.phone,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  store.workingHours,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Đóng Bottom Sheet
              },
              child: const Text('Đóng'),
            ),
          ),
        ],
      ),
    );
  }
}
