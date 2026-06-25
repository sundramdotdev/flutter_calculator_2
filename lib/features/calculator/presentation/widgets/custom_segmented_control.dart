import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';

class CustomSegmentedControl extends ConsumerWidget {
  const CustomSegmentedControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final tabIndex = ref.watch(tabIndexProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      height: 48,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Animated Background for selection
          AnimatedAlign(
            alignment: tabIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          
          // Foreground Items
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ref.read(tabIndexProvider.notifier).setIndex(0);
                    ref.read(activeToolProvider.notifier).setTool(null);
                  },
                  child: Center(
                    child: Text(
                      "Calculator",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: tabIndex == 0 ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                        fontWeight: tabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ref.read(tabIndexProvider.notifier).setIndex(1);
                    ref.read(activeToolProvider.notifier).setTool(null);
                  },
                  child: Center(
                    child: Text(
                      "Tools",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: tabIndex == 1 ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                        fontWeight: tabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
