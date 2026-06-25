import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:calculator/features/calculator/presentation/widgets/calculator_button.dart';

void main() {
  testWidgets('CalculatorScreen integration test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CalculatorScreen(),
        ),
      ),
    );

    // Wait for animations
    await tester.pumpAndSettle();

    // Verify initial display exists (there will be a '0' for the button and for the display)
    expect(find.text('0'), findsWidgets);
    
    // Tap buttons: 7 + 6
    await tester.tap(find.widgetWithText(CalculatorButton, '7').first);
    await tester.pumpAndSettle();
    
    await tester.tap(find.widgetWithText(CalculatorButton, '+').first);
    await tester.pumpAndSettle();
    
    await tester.tap(find.widgetWithText(CalculatorButton, '6').first);
    await tester.pumpAndSettle();

    // The expression display should be 7+6
    expect(find.text('7+6'), findsOneWidget);
  });
}
