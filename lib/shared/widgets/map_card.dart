import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class MapCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final double height;
  final VoidCallback? onTap;
  final VoidCallback? onExpand;

  const MapCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.height = 250,
    this.onTap,
    this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                if (onExpand != null)
                  IconButton(
                    icon: const Icon(Icons.fullscreen,
                        size: AppSpacing.iconMd),
                    onPressed: onExpand,
                    tooltip: 'Fullscreen',
                  ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            width: double.infinity,
            child: InkWell(
              onTap: onTap,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
