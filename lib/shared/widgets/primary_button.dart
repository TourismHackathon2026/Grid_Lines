import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    if (isOutlined) {
      return SizedBox(
        height: height ?? AppSpacing.buttonHeight,
        width: width ?? double.infinity,
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: foregroundColor ?? AppColors.primary,
            side: BorderSide(
              color: isDisabled
                  ? AppColors.disabled
                  : (foregroundColor ?? AppColors.primary),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          ),
          child: _buildChild(context),
        ),
      );
    }

    return SizedBox(
      height: height ?? AppSpacing.buttonHeight,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? (isDisabled ? AppColors.disabled : null),
          foregroundColor: foregroundColor,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(text, style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          )),
        ],
      );
    }
    return Text(text, style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ));
  }
}
