// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HalamanAbsen extends StatefulWidget {
  const HalamanAbsen({super.key});

  @override
  State<HalamanAbsen> createState() => _HalamanAbsenState();
}

class _HalamanAbsenState extends State<HalamanAbsen> {
  @override
  Widget build(BuildContext context) {
    return const AbsensiScreen();
  }
}

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  final double targetLatitude = -0.22482211224068796; // Ganti dengan koordinat absen
  final double targetLongitude = 100.65468463956661; // Ganti dengan koordinat absen
  final double targetRadius = 500; // Radius dalam meter
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                _getCurrentLocation;
              },
              child: const Text('Absen'),
            ),
            const SizedBox(height: 20),
            _currentPosition != null
                ? Text(
                    'Lokasi saat ini: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}')
                : const Text('Belum mendapatkan lokasi.'),
            const SizedBox(height: 20),
            _currentPosition != null
                ? Text(
                    _isWithinRadius()
                        ? 'Anda berada dalam jarak absensi.'
                        : 'Anda berada di luar jarak absensi.',
                    style: TextStyle(
                      color: _isWithinRadius() ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  bool _isWithinRadius() {
    if (_currentPosition == null) return false;

    double distanceInMeters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      targetLatitude,
      targetLongitude,
    );

    return distanceInMeters <= targetRadius;
  }
}
