import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DetailsScreen extends StatelessWidget {
  final Object? data;
  const DetailsScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final args = data as Map<String, dynamic>? ?? {};
    final title = args['title'] as String? ?? 'Details';
    final id = args['id'] as int? ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.article_outlined,
                    size: 64, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                const Text('June 27, 2026',
                    style: TextStyle(color: AppColors.textSecondary)),
                const SizedBox(width: 16),
                const Icon(Icons.person_outlined,
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('User #$id',
                    style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'This is a detailed view for item #$id. '
              'You can place any detailed content here including descriptions, '
              'metrics, charts, or interactive elements specific to this item.',
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text('Share'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}