import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator/features/calculator/presentation/widgets/calculator_button.dart';

void main() {
  testWidgets('CalculatorButton renders text and responds to tap', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: CalculatorButton(
              text: '9',
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('9'), findsOneWidget);

    await tester.tap(find.byType(CalculatorButton));
    await tester.pumpAndSettle();

    expect(wasTapped, isTrue);
  });
}
