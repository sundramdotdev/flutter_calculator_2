import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/settings/haptic_provider.dart';

class CalculatorButton extends ConsumerStatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOperator;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.isOperator = false,
  });

  @override
  ConsumerState<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends ConsumerState<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 40), // 80ms total (40 in, 40 out)
      reverseDuration: const Duration(milliseconds: 40),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    final isHapticEnabled = ref.read(hapticProvider);
    if (isHapticEnabled) {
      if (widget.text == '=') {
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.lightImpact();
      }
    }
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? theme.cardTheme.color,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                widget.text,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: widget.textColor ?? 
                    (widget.isOperator 
                      ? theme.colorScheme.primary 
                      : theme.colorScheme.onSurface),
                  fontWeight: widget.isOperator ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }
}
