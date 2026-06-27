import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🔗 LINKING ALL YOUR REAL UI FILES HERE:
import 'dashboard_tab.dart';
import '../../tracking/screens/tracking_tab.dart';
import '../../profile/screens/profile_tab.dart'; 
import '../../explore/screens/explore_tab.dart'; // ✅ Added the real Explore import!

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 🚀 Now this points to your REAL ExploreTab file instead of the mockup!
    final List<Widget> liveTabs = [
      const DashboardTab(),
      const ExploreTab(), // ✅ Changed from PlacesTab() to ExploreTab()
      const TrackingTab(),
      const ProfileTab(), 
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1C), 
      appBar: AppBar(
        title: const Text(
          'TOURTRACK', 
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 16, letterSpacing: 2.0),
        ),
        backgroundColor: const Color(0xFF0A0F1C),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.white70, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: liveTabs[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF1E293B), width: 0.5)),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          backgroundColor: const Color(0xFF0A0F1C),
          elevation: 0,
          height: 65,
          indicatorColor: const Color(0xFFFF5722).withOpacity(0.15), // Blaze Orange indicator
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.grid_view_rounded, color: Color(0xFFFF5722)),
              label: 'Hub',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.explore, color: Color(0xFFFF5722)),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.near_me_outlined, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.near_me, color: Color(0xFFFF5722)),
              label: 'Track',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.person_rounded, color: Color(0xFFFF5722)),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}