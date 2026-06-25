import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HapticProvider extends Notifier<bool> {
  @override
  bool build() {
    _loadHapticState();
    return true;
  }

  static const String _hapticKey = 'app_haptic_enabled';

  Future<void> _loadHapticState() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_hapticKey);
    if (isEnabled != null) {
      state = isEnabled;
    }
  }

  Future<void> toggleHaptic() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hapticKey, state);
  }
}

final hapticProvider = NotifierProvider<HapticProvider, bool>(() {
  return HapticProvider();
});
