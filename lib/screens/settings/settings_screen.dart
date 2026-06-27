import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _locationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),
          const Divider(),
          const _SectionHeader(title: 'Notifications'),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive push notifications'),
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
          const Divider(),
          const _SectionHeader(title: 'Privacy'),
          SwitchListTile(
            title: const Text('Location Services'),
            subtitle: const Text('Allow location access'),
            value: _locationEnabled,
            onChanged: (value) => setState(() => _locationEnabled = value),
          ),
          const Divider(),
          const _SectionHeader(title: 'General'),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('English', style: TextStyle(color: AppColors.textSecondary)),
                SizedBox(width: 4),
                Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete_outlined),
            title: const Text('Clear Cache'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.system_update_outlined),
            title: const Text('App Version'),
            trailing: const Text('1.0.0',
                style: TextStyle(color: AppColors.textSecondary)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}