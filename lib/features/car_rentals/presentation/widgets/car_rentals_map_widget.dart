import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CarRentalsMapWidget extends StatefulWidget {
  const CarRentalsMapWidget({super.key});

  @override
  State<CarRentalsMapWidget> createState() => _CarRentalsMapWidgetState();
}

class _CarRentalsMapWidgetState extends State<CarRentalsMapWidget> {
  CameraPosition? _cameraPosition;
  String? _error;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

Future<void> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    setState(() {
      _error = "Location services are disabled.";
    });
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      setState(() {
        _error = "Location permission denied.";
      });
      return;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    setState(() {
      _error = "Location permission permanently denied.";
    });
    return;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (!_isDisposed) {
      setState(() {
        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
      });
    }
  } catch (e) {
    if (!_isDisposed) {
      setState(() {
        _error = "Failed to get location: $e";
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }
    return _cameraPosition == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
          initialCameraPosition: _cameraPosition!,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
        );
  }
}
