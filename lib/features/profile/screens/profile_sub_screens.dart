import 'package:flutter/material.dart';

// --------------------------------------------------------
// 1. EDIT PROFILE SCREEN
// --------------------------------------------------------
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D16),
      appBar: AppBar(title: const Text("Edit Profile"), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(radius: 40, backgroundColor: Color(0xFF131B2E), child: Icon(Icons.add_a_photo, color: Colors.white54)),
          const SizedBox(height: 30),
          _buildTextField("First Name", "Sarah"),
          _buildTextField("Last Name", "Bennett"),
          _buildTextField("Contact Number", "+977 980-0000000"),
          const SizedBox(height: 20),
          const Text("FEATURED BADGE", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: const Color(0xFF131B2E), borderRadius: BorderRadius.circular(12)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color(0xFF131B2E),
                value: "Everest Survivor",
                isExpanded: true,
                items: ["Everest Survivor", "100km Trailblazer", "Annapurna Master"].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(color: Colors.white)));
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF14B8A6), padding: const EdgeInsets.symmetric(vertical: 16)),
            onPressed: () => Navigator.pop(context),
            child: const Text("Save Changes", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color(0xFF131B2E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

// --------------------------------------------------------
// 2. SETTINGS SCREEN
// --------------------------------------------------------
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _backgroundTracking = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D16),
      appBar: AppBar(title: const Text("System Settings"), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("PRIVACY & TRACKING", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text("Background GPS Tracking", style: TextStyle(color: Colors.white)),
            subtitle: const Text("Allow app to track location while closed", style: TextStyle(color: Colors.white54, fontSize: 12)),
            activeColor: const Color(0xFF14B8A6),
            value: _backgroundTracking,
            onChanged: (val) => setState(() => _backgroundTracking = val),
            tileColor: const Color(0xFF131B2E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          const SizedBox(height: 30),
          const Text("ACCOUNT SECURITY", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildSettingsAction("Change Email Address", Icons.email_outlined),
          _buildSettingsAction("Reset Password", Icons.lock_outline),
          _buildSettingsAction("Delete Account Data", Icons.delete_forever, isDanger: true),
        ],
      ),
    );
  }

  Widget _buildSettingsAction(String title, IconData icon, {bool isDanger = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: const Color(0xFF131B2E), borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: isDanger ? Colors.redAccent : Colors.white70),
        title: Text(title, style: TextStyle(color: isDanger ? Colors.redAccent : Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
        onTap: () {},
      ),
    );
  }
}

// --------------------------------------------------------
// 3. BADGES SCREEN
// --------------------------------------------------------
class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090D16),
      appBar: AppBar(title: const Text("My Achievements"), backgroundColor: Colors.transparent, elevation: 0),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildBadgeCard("Everest Base Camp", "Completed May 2026", Icons.landscape, true),
          _buildBadgeCard("100km Tracker", "Total distance", Icons.map, true),
          _buildBadgeCard("Annapurna Circuit", "Locked", Icons.lock, false),
          _buildBadgeCard("Pioneer", "Locked", Icons.star_border, false),
        ],
      ),
    );
  }

  Widget _buildBadgeCard(String title, String sub, IconData icon, bool unlocked) {
    return Container(
      decoration: BoxDecoration(
        color: unlocked ? const Color(0xFF131B2E) : const Color(0xFF090D16),
        border: Border.all(color: unlocked ? const Color(0xFF14B8A6).withOpacity(0.3) : Colors.white10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: unlocked ? const Color(0xFF14B8A6) : Colors.white24),
          const SizedBox(height: 12),
          Text(title, textAlign: TextAlign.center, style: TextStyle(color: unlocked ? Colors.white : Colors.white38, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          Text(sub, style: TextStyle(color: Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }
}

// --------------------------------------------------------
// 4. TRAVEL HISTORY & 5. SAVED PLACES (Mock Lists)
// --------------------------------------------------------
class TravelHistoryScreen extends StatelessWidget {
  const TravelHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF090D16),
    appBar: AppBar(title: const Text("Travel History"), backgroundColor: Colors.transparent),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHistoryCard("Thamel-Swayambhu Route", "3.1 km • June 25, 2026"),
        _buildHistoryCard("Durbar Square Link", "2.8 km • June 22, 2026"),
      ],
    ),
  );

  Widget _buildHistoryCard(String title, String data) => Container(
    margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF131B2E), borderRadius: BorderRadius.circular(12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text(data, style: const TextStyle(color: Colors.white54, fontSize: 12)),
    ]),
  );
}

class SavedPlacesScreen extends StatelessWidget {
  const SavedPlacesScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF090D16),
    appBar: AppBar(title: const Text("Saved Homestays"), backgroundColor: Colors.transparent),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHistoryCard("Ghalegaun Gurung Homestay", "Host: Pasang Gurung • Lamjung"),
        _buildHistoryCard("Namche Bazaar Lodge", "Basecamp Route • Solukhumbu"),
      ],
    ),
  );

  Widget _buildHistoryCard(String title, String data) => Container(
    margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF131B2E), borderRadius: BorderRadius.circular(12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text(data, style: const TextStyle(color: Colors.white54, fontSize: 12)),
    ]),
  );
}