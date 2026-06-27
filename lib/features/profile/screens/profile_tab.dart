import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.lg),
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primaryLight,
            child: Text(
              user?.name.isNotEmpty == true
                  ? user!.name[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                  fontSize: 36, color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(user?.name ?? 'User',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(user?.email ?? 'user@example.com',
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.lg),
          _buildTile(Icons.edit, 'Edit Profile',
              () => context.pushNamed(AppRoutes.editProfileName)),
          _buildTile(Icons.badge_outlined, 'My Badges',
              () => context.pushNamed(AppRoutes.badgesName)),
          _buildTile(Icons.history, 'Travel History',
              () => context.pushNamed(AppRoutes.trackingName)),
          _buildTile(Icons.favorite_border, 'Saved Places',
              () => context.pushNamed(AppRoutes.savedPlacesName)),
          _buildTile(Icons.settings_outlined, 'Settings',
              () => context.pushNamed(AppRoutes.settingsName)),
          _buildTile(Icons.help_outlined, 'Help & Support',
              () => context.pushNamed(AppRoutes.helpName)),
          _buildTile(Icons.info_outlined, 'About',
              () => context.pushNamed(AppRoutes.aboutName)),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            text: 'Logout',
            onPressed: () => _showLogoutDialog(context, ref),
            isOutlined: true,
            foregroundColor: AppColors.error,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authProvider.notifier).logout();
              context.goNamed(AppRoutes.loginName);
            },
            child: const Text('Logout',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
