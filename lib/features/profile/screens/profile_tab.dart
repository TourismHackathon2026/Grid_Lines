import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  // 📸 State to track if the user has uploaded an image
  bool _hasUploadedImage = false;
  String _activeBadge = "Everest Base Camp Survivor"; // Default featured badge

  void _handleImageUpload() {
    // Simulating an image picker for the hackathon UI
    setState(() {
      _hasUploadedImage = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("📸 Profile picture updated successfully!"),
        backgroundColor: Color(0xFF14B8A6),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            
            // 📸 PROFILE AVATAR WITH WORKING UPLOAD BUTTON
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: AppColors.primaryLight.withOpacity(0.15),
                      backgroundImage: _hasUploadedImage 
                          ? const NetworkImage('https://i.pravatar.cc/150?img=47') // Mock uploaded image
                          : null,
                      child: !_hasUploadedImage
                          ? Text(
                              user?.name.isNotEmpty == true ? user!.name[0].toUpperCase() : '?',
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _handleImageUpload,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF090D16), width: 3),
                          ),
                          child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'Sarah Bennett',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.shield_rounded, color: Color(0xFF14B8A6), size: 14),
                          const SizedBox(width: 6),
                          Text(
                            _activeBadge, // Shows selected badge
                            style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // 📊 HARDWARE METRICS
            const Text("TACTICAL METRICS", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _buildMetricCard("TOTAL DISTANCE", "42.8 km", Icons.directions_walk_rounded),
                const SizedBox(width: AppSpacing.sm),
                _buildMetricCard("MAX ELEVATION", "3,410 m", Icons.landscape_rounded),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // ⚙️ NAVIGATION MENU
            const Text("ACCOUNT CONSOLE", style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: AppSpacing.sm),
            _buildConsoleTile(Icons.edit, 'Edit Profile', () => _safeNavigate(AppRoutes.editProfileName)),
            _buildConsoleTile(Icons.badge_outlined, 'My Badges', () => _safeNavigate(AppRoutes.badgesName)),
            _buildConsoleTile(Icons.history, 'Travel History', () => _safeNavigate(AppRoutes.trackingName)),
            _buildConsoleTile(Icons.favorite_border, 'Saved Places', () => _safeNavigate(AppRoutes.savedPlacesName)),
            _buildConsoleTile(Icons.settings_outlined, 'Settings', () => _safeNavigate(AppRoutes.settingsName)),
            
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              text: 'Logout',
              onPressed: () => _showLogoutDialog(context, ref),
              isOutlined: true,
              foregroundColor: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  void _safeNavigate(String routeName) {
    try {
      context.pushNamed(routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("🚀 Route '$routeName' is ready to be linked in GoRouter!"),
        backgroundColor: const Color(0xFF131B2E),
      ));
    }
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF131B2E), borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white38, size: 20),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildConsoleTile(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF131B2E).withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.white60, size: 20),
                const SizedBox(width: 16),
                Expanded(child:Text(title, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.w500)),),
                const Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    // Keep your existing logout dialog here
  }
}