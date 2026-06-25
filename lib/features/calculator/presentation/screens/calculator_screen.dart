import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/theme_provider.dart';

import '../providers/calculator_provider.dart';
import '../providers/navigation_provider.dart';

import '../widgets/calculator_keypad.dart';
import '../widgets/custom_segmented_control.dart';
import '../widgets/scientific_keypad.dart';

import '../../../quick_tools/presentation/screens/tools_dashboard.dart';
import '../../../quick_tools/presentation/widgets/gst_calculator_sheet.dart';
import '../../../quick_tools/presentation/widgets/emi_calculator_sheet.dart';
import '../../../quick_tools/presentation/widgets/age_calculator_sheet.dart';
import '../../../quick_tools/presentation/widgets/sip_calculator_sheet.dart';
import '../../../quick_tools/presentation/widgets/units_calculator_sheet.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentTheme = ref.watch(themeProvider);
    final isDark = currentTheme == ThemeMode.dark || 
                  (currentTheme == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Area: History, Theme, Settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () => context.push('/history'),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                        onPressed: () {
                          ref.read(themeProvider.notifier).toggleTheme(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings_outlined),
                        onPressed: () => context.push('/settings'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            
            // Center Area: Display (Takes ~35%)
            const Expanded(
              flex: 3,
              child: _DisplayArea(),
            ),

            // Tab Navigation
            const CustomSegmentedControl(),

            // Bottom Area: Dynamic Content (Keypad or Tools)
            Expanded(
              flex: 6,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: const _DynamicContentArea(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DynamicContentArea extends ConsumerWidget {
  const _DynamicContentArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider);
    final activeTool = ref.watch(activeToolProvider);

    Widget child;
    if (tabIndex == 0) {
      child = const Padding(
        key: ValueKey('calculator_keypad'),
        padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: CalculatorKeypad(),
      );
    } else {
      if (activeTool == null) {
        child = const ToolsDashboard(key: ValueKey('tools_dashboard'));
      } else {
        child = _buildToolPage(activeTool, context, ref);
      }
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        // Shared axis transition (Fade + Slide)
        final slideIn = Tween<Offset>(begin: const Offset(0.05, 0.0), end: Offset.zero).animate(animation);
        final slideOut = Tween<Offset>(begin: const Offset(-0.05, 0.0), end: Offset.zero).animate(animation);

        final isAppearing = child.key == ValueKey(tabIndex == 0 ? 'calculator_keypad' : (activeTool ?? 'tools_dashboard'));
        
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: isAppearing ? slideIn : slideOut,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildToolPage(String toolName, BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    Widget content;
    switch (toolName) {
      case "Scientific":
        content = const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: ScientificKeypad(),
        );
        break;
      case "GST":
        content = const GSTCalculatorSheet();
        break;
      case "EMI":
        content = const EMICalculatorSheet();
        break;
      case "SIP":
        content = const SIPCalculatorSheet();
        break;
      case "Age":
        content = const AgeCalculatorSheet();
        break;
      case "Units":
        content = const UnitsCalculatorSheet();
        break;
      default:
        content = const Center(child: Text("Tool not found"));
    }

    return Container(
      key: ValueKey(toolName),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tool Header with Back Button
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => ref.read(activeToolProvider.notifier).setTool(null),
                ),
                Text(
                  toolName == "Scientific" ? "Scientific Calculator" : toolName,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(child: content),
        ],
      ),
    );
  }
}

class _DisplayArea extends ConsumerWidget {
  const _DisplayArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final expression = ref.watch(calculatorProvider.select((state) => state.expression));
    final result = ref.watch(calculatorProvider.select((state) => state.result));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      alignment: Alignment.bottomRight,
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: AutoSizeText(
                expression.isEmpty ? "0" : expression,
                key: ValueKey<String>(expression),
                style: theme.textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  fontFamily: 'Inter',
                  fontSize: 24, // Re-enforcing prompt requirements
                ),
                textAlign: TextAlign.right,
                maxLines: 3,
                minFontSize: 16,
                overflowReplacement: Text(
                  expression,
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    fontFamily: 'Inter',
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: AutoSizeText(
                result.isEmpty ? "" : "= $result",
                key: ValueKey<String>(result),
                style: AppTypography.calculationResult.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontFamily: 'Space Grotesk',
                  fontSize: 56, // Enforcing minimum size
                ),
                textAlign: TextAlign.right,
                maxLines: 1,
                minFontSize: 32,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
