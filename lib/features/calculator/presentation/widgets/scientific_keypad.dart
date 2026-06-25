import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/calculator_provider.dart';
import 'calculator_button.dart';

class ScientificKeypad extends ConsumerWidget {
  const ScientificKeypad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(calculatorProvider.notifier);
    final state = ref.watch(calculatorProvider);
    final theme = Theme.of(context);

    Widget buildRow(List<Widget> children) {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children.map((w) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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
          CalculatorButton(
            text: state.isRadianMode ? 'RAD' : 'DEG',
            textColor: theme.colorScheme.primary,
            onTap: () => notifier.toggleAngleMode(),
          ),
          CalculatorButton(text: 'sin', onTap: () => notifier.addToken('sin(')),
          CalculatorButton(text: 'cos', onTap: () => notifier.addToken('cos(')),
          CalculatorButton(text: 'tan', onTap: () => notifier.addToken('tan(')),
          CalculatorButton(text: 'pi', onTap: () => notifier.addToken('pi')),
        ]),
        buildRow([
          CalculatorButton(text: '^', isOperator: true, onTap: () => notifier.addToken('^')),
          CalculatorButton(text: 'log', onTap: () => notifier.addToken('log(')),
          CalculatorButton(text: 'ln', onTap: () => notifier.addToken('ln(')),
          CalculatorButton(text: 'sqrt', onTap: () => notifier.addToken('sqrt(')),
          CalculatorButton(text: 'e', onTap: () => notifier.addToken('e')),
        ]),
      ],
    );
  }
}
