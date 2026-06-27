import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            },
            child:
                const Text('Logout', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildDashboardContent(context),
          _buildActivityTab(context),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 64, color: AppColors.disabled),
                SizedBox(height: 16),
                Text('Search', style: TextStyle(color: AppColors.disabled)),
              ],
            ),
          ),
          _buildProfileTab(context),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          Card(
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome back,',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70)),
                        Text('User',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.waving_hand, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Statistics
          Text('Overview', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total', '128', Icons.inventory, AppColors.primary)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Active', '42', Icons.check_circle, AppColors.success)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('Pending', '36', Icons.pending_actions, AppColors.warning)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Done', '50', Icons.done_all, AppColors.info)),
            ],
          ),
          const SizedBox(height: 24),
          // Quick Actions
          Text('Quick Actions', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionChip(Icons.add_circle_outline, 'New Item', AppColors.primary),
              _buildActionChip(Icons.analytics_outlined, 'Reports', AppColors.success),
              _buildActionChip(Icons.group_add_outlined, 'Team', AppColors.warning),
              _buildActionChip(Icons.settings_outlined, 'Settings', AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 24),
          // Recent Activity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
          ...List.generate(5, (index) => ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(Icons.article_outlined, color: AppColors.primary),
            ),
            title: Text('Activity Item ${index + 1}'),
            subtitle: const Text('2 hours ago'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.details,
                arguments: {'id': index, 'title': 'Activity Item ${index + 1}'}),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActivityTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('All Activity',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...List.generate(10, (index) {
          final colors = [AppColors.primary, AppColors.success, AppColors.warning, AppColors.error];
          final icons = [Icons.add, Icons.check, Icons.refresh, Icons.close];
          final titles = ['New item created', 'Task completed', 'Status updated', 'Issue resolved'];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colors[index % 4].withValues(alpha: 0.1),
                child: Icon(icons[index % 4], color: colors[index % 4]),
              ),
              title: Text(titles[index % 4]),
              subtitle: Text('${(index + 1) * 15} minutes ago'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.details,
                  arguments: {'id': index, 'title': 'Activity #${index + 1}'}),
            ),
          );
        }),
      ],
    );
  }


  Widget _buildProfileTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primaryLight,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text('User Name',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const Text('user@example.com', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          _buildProfileTile(Icons.edit, 'Edit Profile', () {}),
          _buildProfileTile(Icons.lock_outlined, 'Change Password', () {}),
          _buildProfileTile(Icons.notifications_outlined, 'Notifications', () {}),
          _buildProfileTile(Icons.settings_outlined, 'Settings',
              () => Navigator.of(context).pushNamed(AppRoutes.settings)),
          _buildProfileTile(Icons.info_outlined, 'About', () {}),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text('Logout', style: TextStyle(color: AppColors.error)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 2),
                  Text(value,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold, color: color)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(icon: Icon(icon, color: color), onPressed: () {}),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }



  }
