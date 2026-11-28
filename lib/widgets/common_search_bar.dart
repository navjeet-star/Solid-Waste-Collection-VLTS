import 'package:flutter/material.dart';

/// A reusable, compact, and responsive Search Bar component.
///
/// Features:
/// - Configurable height (defaults to 42.0)
/// - Search prefix icon with customizable size and color
/// - Automatic clear ('X') button when query text is non-empty
/// - Customizable border radius, background color, and border styling
/// - Theme-aware styling with Material 3 support
/// - Supports external [controller] or manages internal controller automatically
class CommonSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onSubmitted;
  final double height;
  final IconData? prefixIcon;
  final double prefixIconSize;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? prefixIconColor;
  final Color? textColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final TextInputAction textInputAction;

  const CommonSearchBar({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onClear,
    this.onSubmitted,
    this.height = 42.0,
    this.prefixIcon = Icons.search_rounded,
    this.prefixIconSize = 18.0,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.prefixIconColor,
    this.textColor,
    this.hintColor,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.textInputAction = TextInputAction.search,
  });

  @override
  State<CommonSearchBar> createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {
  late TextEditingController _effectiveController;
  bool _isInternalController = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _effectiveController = TextEditingController();
      _isInternalController = true;
    } else {
      _effectiveController = widget.controller!;
    }

    _hasText = _effectiveController.text.isNotEmpty;
    _effectiveController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant CommonSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onTextChanged);
      if (widget.controller == null) {
        _effectiveController = TextEditingController();
        _isInternalController = true;
      } else {
        if (_isInternalController) {
          _effectiveController.dispose();
          _isInternalController = false;
        }
        _effectiveController = widget.controller!;
      }
      _hasText = _effectiveController.text.isNotEmpty;
      _effectiveController.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_onTextChanged);
    if (_isInternalController) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _effectiveController.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _handleClear() {
    _effectiveController.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveRadius = widget.borderRadius ?? BorderRadius.circular(10);

    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: _effectiveController,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        textInputAction: widget.textInputAction,
        onSubmitted: (_) => widget.onSubmitted?.call(),
        style: widget.textStyle ??
            TextStyle(
              fontSize: 13,
              color: widget.textColor ?? colorScheme.onSurface,
            ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              TextStyle(
                fontSize: 13,
                color: widget.hintColor ??
                    colorScheme.onSurfaceVariant.withValues(alpha: 0.65),
              ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: widget.prefixIconSize,
                  color: widget.prefixIconColor ?? colorScheme.onSurfaceVariant,
                )
              : null,
          suffixIcon: _hasText
              ? IconButton(
                  icon: const Icon(Icons.close_rounded, size: 16),
                  color: colorScheme.onSurfaceVariant,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _handleClear,
                )
              : null,
          filled: true,
          fillColor: widget.backgroundColor ??
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.25),
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: effectiveRadius,
            borderSide: BorderSide(
              color: widget.borderColor ??
                  colorScheme.outline.withValues(alpha: 0.15),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveRadius,
            borderSide: BorderSide(
              color: widget.borderColor ??
                  colorScheme.outline.withValues(alpha: 0.15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveRadius,
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? colorScheme.primary,
              width: 1.2,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
