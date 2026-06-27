import 'dart:async';
import 'dart:math';
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

  // Selected preset route index indicator
  int _selectedRouteIndex = 0;

  // Live real-time hardware positioning coordinates
  LatLng _currentPosition = const LatLng(27.7172, 85.3240); // Baseline Kathmandu location
  String _altitude = "1,400m";
  String _speed = "0.0 km/h";

  // 🏨 TARGET OFFLINE BASE CAMP HOTEL COORDINATES
  final LatLng _hotelTargetLocation = const LatLng(27.7112, 85.3210); 
  double _bearingToHotel = 0.0;
  double _distanceToHotel = 0.0;

  // 🏔️ HARDCODED OFFLINE PATTERNS (Pre-mapped waypoint segments between nodes)
  final List<Map<String, dynamic>> _offlinePopularRoutes = [
    {
      "name": "1. Thamel-Swayambhu Loop Link",
      "tag": "MOST USED",
      "distance": "3.1km",
      "color": const Color(0xFF14B8A6),
      "waypoints": [
        const LatLng(27.7172, 85.3240), // Live tracker start anchor point
        const LatLng(27.7155, 85.3180),
        const LatLng(27.7130, 85.3150),
        const LatLng(27.7112, 85.3210), // Terminating exactly at your Checked-In Hotel Location!
      ]
    },
    {
      "name": "2. Durbar Square Heritage Connector",
      "tag": "POPULAR",
      "distance": "2.8km",
      "color": const Color(0xFF3B82F6),
      "waypoints": [
        const LatLng(27.7172, 85.3240), // Live tracker start anchor point
        const LatLng(27.7100, 85.3235),
        const LatLng(27.7112, 85.3210), // Terminating exactly at your Checked-In Hotel Location!
      ]
    },
    {
      "name": "3. Pashupatinath Link Corridor",
      "tag": "CULTURAL",
      "distance": "4.5km",
      "color": const Color(0xFFA855F7),
      "waypoints": [
        const LatLng(27.7172, 85.3240), // Live tracker start anchor point
        const LatLng(27.7200, 85.3290),
        const LatLng(27.7150, 85.3250),
        const LatLng(27.7112, 85.3210), // Terminating exactly at your Checked-In Hotel Location!
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

    _gpsStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 3),
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
    // Dynamically re-route path endpoint point variables to lock directly onto our current coordinates
    List<LatLng> activePoints = List.from(_offlinePopularRoutes[_selectedRouteIndex]["waypoints"]);
    if (activePoints.isNotEmpty) {
      activePoints[0] = _currentPosition; // Dynamically binds the start of path directly to your hardware location
    }

    Set<Polyline> activePolylines = {
      Polyline(
        polylineId: PolylineId("offline_trek_path_$_selectedRouteIndex"),
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
          // SATELLITE CANVAS VIEW
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 14),
              mapType: MapType.satellite, 
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              polylines: activePolylines,
              onMapCreated: (controller) => _mapController = controller,
              markers: {
                // 📍 Live current location tracking marker
                Marker(
                  markerId: const MarkerId("user_loc_offline"), 
                  position: _currentPosition,
                  infoWindow: const InfoWindow(title: "Your Location (Offline Satellite Lock)"),
                ),
                // 🏨 The active checked-in hotel sanctuary location marker
                Marker(
                  markerId: const MarkerId("hotel_target_sanctuary"), 
                  position: _hotelTargetLocation, 
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                  infoWindow: const InfoWindow(title: "Base Camp Hotel Sanctuary"),
                ),
              },
            ),
          ),

          // TOP STATUS HUD MATRIX READOUT OVERLAY
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
                      const Text("BASE BEACON", style: TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold)),
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

          // LOWER CONSOLE PANEL (Paths listing menu + Floating Vector Radar Grid Box)
          Positioned(
            left: 16,
            right: 16,
            bottom: 84,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Left Card Array: Path Switcher
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF090D16).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("SELECT MOST USED CONNECTING TRAIL", style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(_offlinePopularRoutes.length, (index) {
                            bool isSelected = _selectedRouteIndex == index;
                            var route = _offlinePopularRoutes[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedRouteIndex = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white.withOpacity(0.06) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(route["name"], style: TextStyle(color: isSelected ? Colors.white : Colors.white60, fontSize: 12, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                                        const SizedBox(height: 2),
                                        Text("Est: ${route["distance"]} to base", style: const TextStyle(color: Colors.white38, fontSize: 10)),
                                      ],
                                    ),
                                    if (isSelected)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(color: route["color"].withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                                        child: Text(route["tag"], style: TextStyle(color: route["color"], fontSize: 8, fontWeight: FontWeight.bold)),
                                      )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Right Card: Floating Vector Radar Compass Component
                if (_isHotelBeaconLocked && _isTrackingActive)
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 168,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF090D16).withOpacity(0.95),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF14B8A6).withOpacity(0.3)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("RETURN HUD", style: TextStyle(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Transform.rotate(
                            angle: (_bearingToHotel * pi / 180),
                            child: const Icon(Icons.navigation_rounded, size: 40, color: Color(0xFF14B8A6)),
                          ),
                          const SizedBox(height: 12),
                          Text("${_distanceToHotel.toStringAsFixed(0)}m", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                          const Text("direct vector", style: TextStyle(color: Colors.white38, fontSize: 9)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // CORE SYSTEM ACTION EXECUTION RUNNER BUTTON
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: _isTrackingActive ? const Color(0xFFEF4444) : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: _toggleHardwareTracking,
              child: Text(
                _isTrackingActive ? "Pause Core Telemetry Engine" : "Engage Offline Path Tracker",
                style: TextStyle(color: _isTrackingActive ? Colors.white : Colors.black, fontWeight: FontWeight.w700, fontSize: 13),
              ),
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