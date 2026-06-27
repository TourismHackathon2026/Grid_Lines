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
  
  // New Theme Colors
  final Color bgDark = const Color(0xFF0A0F1C);
  final Color cardDark = const Color(0xFF171E2E);
  final Color blazeOrange = const Color(0xFFFF5722);

  // 🏔️ ASSET DATA: Exact file names from your VS Code screenshot
  final List<Map<String, String>> _suggestedPlaces = [
    {
      "name": "Everest Base Camp",
      "location": "Solukhumbu Region",
      "image": "assets/images/everest_base camp.jpg",
      "difficulty": "Extreme"
    },
    {
      "name": "Annapurna Circuit",
      "location": "Gandaki Province",
      "image": "assets/images/anapurna circut.jpg",
      "difficulty": "Hard"
    },
    {
      "name": "Swayambhunath",
      "location": "Kathmandu Valley",
      "image": "assets/images/swyambu.jpg",
      "difficulty": "Easy"
    },
    {
      "name": "Fewa Lake",
      "location": "Pokhara",
      "image": "assets/images/fewa_tal.jpg",
      "difficulty": "Easy"
    },
  ];

  void _executeOfflineCheckIn() {
    setState(() {
      _hasCheckedIn = true;
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(9);
      _generatedOfflineToken = "TIMS-BASE-$timestamp";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: bgDark,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome back,", style: TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 4),
                  const Text("Sarah Bennett", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
                  const SizedBox(height: 24),

                  // ACTIVE STATUS CARD
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardDark,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.satellite_alt_rounded, color: blazeOrange, size: 20),
                                const SizedBox(width: 10),
                                const Text("OFFLINE ANCHOR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 1)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: _hasCheckedIn ? Colors.green.withOpacity(0.2) : Colors.white10, borderRadius: BorderRadius.circular(20)),
                              child: Text(_hasCheckedIn ? "SECURE" : "STANDBY", style: TextStyle(color: _hasCheckedIn ? Colors.greenAccent : Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (!_hasCheckedIn) ...[
                          const Text("Cache your local basecamp coordinates to ensure safe return vectors.", style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.5)),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: blazeOrange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              onPressed: _executeOfflineCheckIn,
                              child: const Text("Initialize Sync", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ] else ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("ACTIVE TIMS TOKEN", style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                const SizedBox(height: 4),
                                Text(_generatedOfflineToken, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 14, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // SUGGESTED EXPEDITIONS CAROUSEL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Explore Nepal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("View Map", style: TextStyle(color: blazeOrange, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            
            SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _suggestedPlaces.length,
                itemBuilder: (context, index) {
                  final place = _suggestedPlaces[index];
                  return Container(
                    width: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: AssetImage(place["image"]!), // Loads your local VS Code image
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        // Gorgeous gradient overlay to make white text pop over images
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, bgDark.withOpacity(0.8), bgDark],
                          stops: const [0.4, 0.8, 1.0],
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: blazeOrange.withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
                            child: Text(place["difficulty"]!, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 8),
                          Text(place["name"]!, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, height: 1.1)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.white54, size: 12),
                              const SizedBox(width: 4),
                              Expanded(child: Text(place["location"]!, style: const TextStyle(color: Colors.white54, fontSize: 11), overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}