import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class AppSearchBar extends StatefulWidget {
  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppSearchBar({
    super.key,
    this.hint = 'Search...',
    this.onChanged,
    this.onClear,
    this.onFilterTap,
    this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.buttonHeight,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: TextField(
        controller: _controller,
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon:
              const Icon(Icons.search, size: AppSpacing.iconMd),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_hasText)
                IconButton(
                  icon: const Icon(Icons.clear, size: AppSpacing.iconMd),
                  onPressed: () {
                    _controller.clear();
                    widget.onClear?.call();
                    widget.onChanged?.call('');
                  },
                ),
              if (widget.onFilterTap != null)
                IconButton(
                  icon: const Icon(Icons.filter_list,
                      size: AppSpacing.iconMd),
                  onPressed: widget.onFilterTap,
                ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
