import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator/features/calculator/presentation/providers/calculator_provider.dart';

void main() {
  group('CalculatorNotifier Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state should be empty', () {
      final state = container.read(calculatorProvider);
      expect(state.expression, '');
      expect(state.result, '');
    });

    test('Tapping numbers should build expression correctly', () {
      final notifier = container.read(calculatorProvider.notifier);
      notifier.addToken('1');
      notifier.addToken('2');
      notifier.addToken('3');
      final state = container.read(calculatorProvider);
      expect(state.expression, '123');
    });

    test('Tapping operators should format expression correctly', () {
      final notifier = container.read(calculatorProvider.notifier);
      notifier.addToken('2');
      notifier.addToken('+');
      notifier.addToken('3');
      final state = container.read(calculatorProvider);
      expect(state.expression, '2+3');
    });

    test('Duplicate sequential operators should be replaced', () {
      final notifier = container.read(calculatorProvider.notifier);
      notifier.addToken('5');
      notifier.addToken('+');
      notifier.addToken('-');
      final state = container.read(calculatorProvider);
      expect(state.expression, '5-');
    });

    test('Clear (AC) should reset the state', () {
      final notifier = container.read(calculatorProvider.notifier);
      notifier.addToken('1');
      notifier.addToken('+');
      notifier.addToken('2');
      notifier.clear();
      final state = container.read(calculatorProvider);
      expect(state.expression, '');
      expect(state.result, '');
    });

    test('Delete (⌫) should remove the last character', () {
      final notifier = container.read(calculatorProvider.notifier);
      notifier.addToken('1');
      notifier.addToken('2');
      notifier.delete();
      final state = container.read(calculatorProvider);
      expect(state.expression, '1');
    });
  });
}
