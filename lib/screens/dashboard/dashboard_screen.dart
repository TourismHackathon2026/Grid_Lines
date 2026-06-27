import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatCard(context, 'Total Items', '128', Icons.inventory,
              AppColors.primary),
          const SizedBox(height: 12),
          _buildStatCard(
              context, 'Active', '42', Icons.check_circle, AppColors.success),
          const SizedBox(height: 12),
          _buildStatCard(context, 'Pending', '36', Icons.pending_actions,
              AppColors.warning),
          const SizedBox(height: 12),
          _buildStatCard(
              context, 'Completed', '50', Icons.done_all, AppColors.info),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
      ),
    );
  }
}