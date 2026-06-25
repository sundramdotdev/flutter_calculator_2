import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/calculator_provider.dart';
import 'calculator_button.dart';

class CalculatorKeypad extends ConsumerWidget {
  const CalculatorKeypad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(calculatorProvider.notifier);
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;

    Widget buildRow(List<Widget> children) {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children.map((w) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: w,
            )
          )).toList(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildRow([
          CalculatorButton(text: 'C', textColor: errorColor, onTap: () => notifier.clear()),
          CalculatorButton(text: '(', isOperator: true, onTap: () => notifier.addToken('(')),
          CalculatorButton(text: ')', isOperator: true, onTap: () => notifier.addToken(')')),
          CalculatorButton(text: '÷', isOperator: true, onTap: () => notifier.addToken('÷')),
        ]),
        buildRow([
          CalculatorButton(text: '7', onTap: () => notifier.addToken('7')),
          CalculatorButton(text: '8', onTap: () => notifier.addToken('8')),
          CalculatorButton(text: '9', onTap: () => notifier.addToken('9')),
          CalculatorButton(text: '×', isOperator: true, onTap: () => notifier.addToken('×')),
        ]),
        buildRow([
          CalculatorButton(text: '4', onTap: () => notifier.addToken('4')),
          CalculatorButton(text: '5', onTap: () => notifier.addToken('5')),
          CalculatorButton(text: '6', onTap: () => notifier.addToken('6')),
          CalculatorButton(text: '-', isOperator: true, onTap: () => notifier.addToken('-')),
        ]),
        buildRow([
          CalculatorButton(text: '1', onTap: () => notifier.addToken('1')),
          CalculatorButton(text: '2', onTap: () => notifier.addToken('2')),
          CalculatorButton(text: '3', onTap: () => notifier.addToken('3')),
          CalculatorButton(text: '+', isOperator: true, onTap: () => notifier.addToken('+')),
        ]),
        buildRow([
          CalculatorButton(text: '0', onTap: () => notifier.addToken('0')),
          CalculatorButton(text: '.', onTap: () => notifier.addToken('.')),
          CalculatorButton(text: '⌫', textColor: errorColor, onTap: () => notifier.delete()),
          CalculatorButton(
            text: '=',
            backgroundColor: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            onTap: () => notifier.calculate(),
          ),
        ]),
      ],
    );
  }
}
