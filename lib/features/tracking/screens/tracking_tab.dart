import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart'; // For kIsWeb checks
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TrackingTab extends StatefulWidget {
  const TrackingTab({Key? key}) : super(key: key);

  @override
  State<TrackingTab> createState() => _TrackingTabState();
}

class _TrackingTabState extends State<TrackingTab> {
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _gpsStreamSubscription;
  bool _isTrackingActive = false;
  bool _isHotelBeaconLocked = false;

  int _selectedRouteIndex = 0;
  LatLng _currentPosition = const LatLng(27.7172, 85.3240); 
  String _altitude = "1,400m";
  String _speed = "0.0 km/h";

  final LatLng _hotelTargetLocation = const LatLng(27.7112, 85.3210); 
  double _bearingToHotel = 0.0;
  double _distanceToHotel = 0.0;

  final List<Map<String, dynamic>> _offlinePopularRoutes = [
    {
      "name": "1. Thamel-Swayambhu Loop Link",
      "tag": "MOST USED",
      "distance": "3.1km",
      "color": const Color(0xFF14B8A6),
      "waypoints": [
        const LatLng(27.7172, 85.3240), 
        const LatLng(27.7155, 85.3180),
        const LatLng(27.7130, 85.3150),
        const LatLng(27.7112, 85.3210), 
      ]
    },
    {
      "name": "2. Durbar Square Heritage Connector",
      "tag": "POPULAR",
      "distance": "2.8km",
      "color": const Color(0xFF3B82F6),
      "waypoints": [
        const LatLng(27.7172, 85.3240),
        const LatLng(27.7100, 85.3235),
        const LatLng(27.7112, 85.3210),
      ]
    }
  ];

  void _calculateOfflineVectors(double userLat, double userLng) {
    double p = 0.017453292519943295;
    double a = 0.5 - cos((_hotelTargetLocation.latitude - userLat) * p) / 2 + 
          cos(userLat * p) * cos(_hotelTargetLocation.latitude * p) * (1 - cos((_hotelTargetLocation.longitude - userLng) * p)) / 2;
    double distanceMeters = 12742000 * asin(sqrt(a));

    double dLon = (_hotelTargetLocation.longitude - userLng) * p;
    double brng = atan2(sin(dLon) * cos(_hotelTargetLocation.latitude * p), cos(userLat * p) * sin(_hotelTargetLocation.latitude * p) - sin(userLat * p) * cos(_hotelTargetLocation.latitude * p) * cos(dLon)) / p;
    
    setState(() {
      _distanceToHotel = distanceMeters;
      _bearingToHotel = (brng + 360) % 360;
    });
  }

  // 🚀 HIGH PRECISION HARDWARE INITIALIZATION METHOD
  void _toggleHardwareTracking() async {
    if (_isTrackingActive) {
      await _gpsStreamSubscription?.cancel();
      setState(() => _isTrackingActive = false);
      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    setState(() => _isTrackingActive = true);

    // 📱 PLATFORM-SPECIFIC HIGH ACCURACY CONFIGURATION LAYER
    LocationSettings locationSettings;

    if (kIsWeb) {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 2,
      );
    } else {
      // Hardware-level tracking variables optimized strictly for Android & iOS Mobile Devices
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation, // 🔥 Crucial for real hardware pin accuracy
        distanceFilter: 2, // Emits refresh callback every 2 meters traveled
        forceLocationManager: true, // Uses GPS satellites directly, bypassing cellular masts completely
        intervalDuration: const Duration(seconds: 1), // Checks satellite lock frequency every second
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "TourTrack is securely monitoring your trail location offline.",
          notificationTitle: "Tactical Path Sync Active",
          enableWakeLock: true, // Prevents CPU deep-sleep power savings modes on trail blackouts
        ),
      );
    }

    _gpsStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      if (!mounted) return;
      _calculateOfflineVectors(position.latitude, position.longitude);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _altitude = "${position.altitude.toStringAsFixed(0)}m";
        _speed = "${(position.speed * 3.6).toStringAsFixed(1)} km/h";
      });
      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
    });
  }

  @override
  void dispose() {
    _gpsStreamSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<LatLng> activePoints = List.from(_offlinePopularRoutes[_selectedRouteIndex]["waypoints"]);
    if (activePoints.isNotEmpty) {
      activePoints[0] = _currentPosition; 
    }

    Set<Polyline> activePolylines = {
      Polyline(
        polylineId: PolylineId("offline_path_$_selectedRouteIndex"),
        points: activePoints,
        color: _offlinePopularRoutes[_selectedRouteIndex]["color"],
        width: 6,
        geodesic: true,
      )
    };

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 15),
              mapType: MapType.satellite, 
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              polylines: activePolylines,
              onMapCreated: (controller) => _mapController = controller,
              markers: {
                Marker(
                  markerId: const MarkerId("user_loc_offline"), 
                  position: _currentPosition,
                ),
                Marker(
                  markerId: const MarkerId("hotel_target_sanctuary"), 
                  position: _hotelTargetLocation, 
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                ),
              },
            ),
          ),

          // HUD PANEL
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF090D16).withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildHUDTile("ALTITUDE", _altitude),
                  _buildHUDTile("VELOCITY", _speed),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("MARK BASECAMP", style: TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 16,
                        child: Switch(
                          value: _isHotelBeaconLocked,
                          activeColor: Colors.white,
                          onChanged: (val) => setState(() => _isHotelBeaconLocked = val),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          // RADAR COMPASS
          if (_isHotelBeaconLocked && _isTrackingActive)
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFF090D16).withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: (_bearingToHotel * pi / 180),
                        child: const Icon(Icons.navigation_rounded, size: 36, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 12,
                        child: Text("${_distanceToHotel.toStringAsFixed(0)}m", style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      )
                    ],
                  ),
                ),
              ),
            ),

          // FOOTER EXECUTION ACTION TRIGGER
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Minimalist inline list view card panel switcher menu
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(color: const Color(0xFF090D16).withOpacity(0.95), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
                  child: Column(
                    children: List.generate(_offlinePopularRoutes.length, (index) {
                      bool isSelected = _selectedRouteIndex == index;
                      var route = _offlinePopularRoutes[index];
                      return ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        title: Text(route["name"], style: TextStyle(color: isSelected ? Colors.white : Colors.white60, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                        trailing: isSelected ? Text(route["tag"], style: TextStyle(color: route["color"], fontSize: 9, fontWeight: FontWeight.bold)) : null,
                        onTap: () => setState(() => _selectedRouteIndex = index),
                      );
                    }),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: _isTrackingActive ? Colors.redAccent : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _toggleHardwareTracking,
                  child: Text(
                    _isTrackingActive ? "Pause Core Telemetry Engine" : "Engage Offline Path Tracker",
                    style: TextStyle(color: _isTrackingActive ? Colors.white : Colors.black, fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHUDTile(String label, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(data, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
      ],
    );
  }
}