import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _location = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: [
        const _SectionHeader(title: 'Appearance'),
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Enable dark theme'),
          value: _darkMode,
          onChanged: (v) => setState(() => _darkMode = v),
          secondary: const Icon(Icons.dark_mode_outlined),
        ),
        const Divider(indent: 72),
        const _SectionHeader(title: 'Notifications'),
        SwitchListTile(
          title: const Text('Push Notifications'),
          subtitle: const Text('Receive alerts and updates'),
          value: _notifications,
          onChanged: (v) => setState(() => _notifications = v),
          secondary: const Icon(Icons.notifications_outlined),
        ),
        const Divider(indent: 72),
        const _SectionHeader(title: 'Privacy & Location'),
        SwitchListTile(
          title: const Text('Location Services'),
          subtitle: const Text('Allow location tracking'),
          value: _location,
          onChanged: (v) => setState(() => _location = v),
          secondary: const Icon(Icons.location_on_outlined),
        ),
        const Divider(indent: 72),
        const _SectionHeader(title: 'General'),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          trailing: const Row(mainAxisSize: MainAxisSize.min, children: [
            Text('English',
                style: TextStyle(color: AppColors.textSecondary)),
            SizedBox(width: 4),
            Icon(Icons.chevron_right),
          ]),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.delete_outlined),
          title: const Text('Clear Cache'),
          trailing: const Text('32 MB',
              style: TextStyle(color: AppColors.textSecondary)),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.system_update_outlined),
          title: const Text('App Version'),
          trailing: const Text('1.0.0',
              style: TextStyle(color: AppColors.textSecondary)),
        ),
        const SizedBox(height: AppSpacing.lg),
      ]),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(title,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600,
              color: AppColors.primary, letterSpacing: 0.5)),
    );
  }
}
