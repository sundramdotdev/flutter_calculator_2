import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/settings/haptic_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentTheme = ref.watch(themeProvider);
    final isHapticEnabled = ref.watch(hapticProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Appearance", style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            )),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text("Theme"),
            subtitle: const Text("Choose app visual style"),
            trailing: DropdownButton<ThemeMode>(
              value: currentTheme,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text("System Default")),
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light Mode")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark Mode")),
              ],
              onChanged: (ThemeMode? mode) {
                if (mode != null) {
                  ref.read(themeProvider.notifier).setTheme(mode);
                }
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Feedback", style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            )),
          ),
          ListTile(
            leading: const Icon(Icons.vibration),
            title: const Text("Haptic Feedback"),
            subtitle: const Text("Vibrate on keypad press"),
            trailing: Switch(
              value: isHapticEnabled,
              onChanged: (val) {
                ref.read(hapticProvider.notifier).toggleHaptic();
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("About", style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            )),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Version"),
            subtitle: Text("1.0.0+1"),
          ),
          const ListTile(
            leading: Icon(Icons.code),
            title: Text("Architecture"),
            subtitle: Text("Flutter Riverpod & Clean Architecture"),
          ),
        ],
      ),
    );
  }
}
