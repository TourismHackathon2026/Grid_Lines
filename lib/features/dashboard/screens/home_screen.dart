import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_tab.dart';
import '../../tracking/screens/tracking_tab.dart';

// Minimalistic fallback tab modules to keep imports clean
class PlacesTab extends StatelessWidget {
  const PlacesTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(
        child: Text("EXPLORE REGIONS", style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold)),
      );
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const Center(
        child: Text("TREKKER PROFILE", style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold)),
      );
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> liveTabs = [
      const DashboardTab(),
      const PlacesTab(),
      const TrackingTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF090D16), // Premium Minimal Dark Obsidian
      appBar: AppBar(
        title: const Text(
          'TOURTRACK', 
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 15, letterSpacing: 1.5),
        ),
        backgroundColor: const Color(0xFF090D16),
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
          backgroundColor: const Color(0xFF090D16),
          elevation: 0,
          height: 65,
          indicatorColor: Colors.white.withOpacity(0.05),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.grid_view_rounded, color: Colors.white),
              label: 'Hub',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.explore, color: Colors.white),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.near_me_outlined, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.near_me, color: Colors.white),
              label: 'Track',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded, color: Colors.white38, size: 20),
              selectedIcon: Icon(Icons.person_rounded, color: Colors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}