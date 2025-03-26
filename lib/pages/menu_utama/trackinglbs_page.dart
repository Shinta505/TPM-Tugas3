import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class TrackinglbsPage extends StatefulWidget {
  const TrackinglbsPage({super.key});

  @override
  State<TrackinglbsPage> createState() => _TrackinglbsPageState();
}

class _TrackinglbsPageState extends State<TrackinglbsPage> {
  LatLng _currentPosition = const LatLng(-6.2088, 106.8456); // Default Jakarta
  final MapController _mapController = MapController();
  double _currentZoom = 14.0;

  final Map<String, LatLng> locations = {
    'Jakarta': LatLng(-6.2088, 106.8456),
    'Bandung': LatLng(-6.9147, 107.6098),
    'Surabaya': LatLng(-7.2575, 112.7521),
    'Yogyakarta': LatLng(-7.7956, 110.3695),
    'Bali': LatLng(-8.4095, 115.1889),
  };

  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Aktifkan layanan lokasi")),
        );
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Izin lokasi ditolak secara permanen")),
          );
        }
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _mapController.move(_currentPosition, _currentZoom);
      });
    }
  }

  void _changeLocation(String? location) {
    if (location != null) {
      setState(() {
        _selectedLocation = location;
        _currentPosition = locations[location]!;
        _mapController.move(_currentPosition, _currentZoom);
      });
    }
  }

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      _mapController.move(_currentPosition, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      _mapController.move(_currentPosition, _currentZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Tracking LBS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF235D32),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedLocation,
              hint: const Text("Pilih Lokasi"),
              isExpanded: true,
              items: locations.keys.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: _changeLocation,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentPosition,
                    initialZoom: _currentZoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _currentPosition,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 100,
                  right: 25,
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Pastikan tidak terlalu memanjang
                    children: [
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.green,
                        onPressed: _zoomIn,
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      const SizedBox(
                          height: 15), // Jarak lebih besar agar tidak bertumpuk
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.green,
                        onPressed: _zoomOut,
                        child: const Icon(Icons.remove, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF77A36E),
        onPressed: _determinePosition,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
