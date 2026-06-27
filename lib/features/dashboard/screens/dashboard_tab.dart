import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  bool _isOverlayOpen = false;
  bool _hasCheckedIn = false;
  String _generatedOfflineToken = "PENDING_CHECK_IN";
  
  double _headingToShelter = 120.0; 
  double _distanceToShelter = 450.0; 
  Timer? _navigationUpdateTimer;

  final Map<String, String> _activeShelter = {
    "name": "Ghalegaun Gurung Homestay",
    "host": "Pasang Gurung",
    "id": "H-GHALE-08"
  };

  void _executeOfflineCheckIn() {
    setState(() {
      _hasCheckedIn = true;
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(9);
      _generatedOfflineToken = "TIMS-${_activeShelter['id']}-$timestamp";
    });

    _navigationUpdateTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!mounted || !_hasCheckedIn) return;
      setState(() {
        _headingToShelter = (120.0 + sin(timer.tick / 6) * 8) % 360;
        _distanceToShelter = max(10.0, 450.0 - (timer.tick * 1.5) % 200);
      });
    });
  }

  void _clearCheckIn() {
    _navigationUpdateTimer?.cancel();
    setState(() {
      _hasCheckedIn = false;
      _generatedOfflineToken = "PENDING_CHECK_IN";
    });
  }

  @override
  void dispose() {
    _navigationUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello, Sarah", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.5)),
            const SizedBox(height: 4),
            const Text("Token: ETIMS-TK-8821 Active", style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 32),

            // MINIMALISTIC HOMESTAY ACTION CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E), // Modern dark indigo slate
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_activeShelter['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text("Host: ${_activeShelter['host']}", style: const TextStyle(color: Colors.white38, fontSize: 12)),
                          ],
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.04),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => setState(() => _isOverlayOpen = !_isOverlayOpen),
                        child: Text(_isOverlayOpen ? "Hide" : "Manage", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),

                  // INLINE EXTENSION DRAWER WINDOW
                  if (_isOverlayOpen) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(color: Colors.white10),
                    ),
                    if (!_hasCheckedIn) ...[
                      const Text(
                        "Registration Required", 
                        style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Synchronize your data token offline to cache base coordinates into local app storage.",
                        style: TextStyle(color: Colors.white38, fontSize: 12, height: 1.4)
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _executeOfflineCheckIn,
                          child: const Text("Initialize Offline Check-In", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13)),
                        ),
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("REGISTRATION TOKEN", style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            const SizedBox(height: 4),
                            SelectableText(_generatedOfflineToken, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform.rotate(angle: (_headingToShelter * pi / 180), child: const Icon(Icons.navigation_outlined, color: Colors.white70, size: 16)),
                              const SizedBox(width: 8),
                              Text("${_distanceToShelter.toStringAsFixed(0)}m to base", style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          GestureDetector(
                            onTap: _clearCheckIn,
                            child: const Text("Check Out", style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w600)),
                          )
                        ],
                      )
                    ]
                  ]
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text("TRAIL CONTEXT", style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF131B2E), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const Text("🏔️", style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Ghalegaun Heritage Loop", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                      SizedBox(height: 2),
                      Text("Lamjung District", style: TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}