import 'package:flutter/material.dart';
import 'dart:math' as math;

class SIPCalculatorSheet extends StatefulWidget {
  const SIPCalculatorSheet({super.key});

  @override
  State<SIPCalculatorSheet> createState() => _SIPCalculatorSheetState();
}

class _SIPCalculatorSheetState extends State<SIPCalculatorSheet> {
  final TextEditingController _investmentController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _investmentController.dispose();
    _rateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final p = double.tryParse(_investmentController.text) ?? 0.0;
    final r = double.tryParse(_rateController.text) ?? 0.0;
    final t = double.tryParse(_timeController.text) ?? 0.0;

    double investedAmount = 0.0;
    double expectedReturns = 0.0;
    double totalValue = 0.0;

    if (p > 0 && r > 0 && t > 0) {
      final double i = r / 100 / 12;
      final double n = t * 12;
      
      investedAmount = p * n;
      totalValue = p * ((math.pow(1 + i, n) - 1) / i) * (1 + i);
      expectedReturns = totalValue - investedAmount;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            TextField(
              controller: _investmentController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Monthly Investment",
                prefixText: "₹ ",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Expected Return Rate",
                suffixText: "% p.a.",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Time Period",
                suffixText: "Years",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 32),
            _buildResultRow("Invested Amount", "₹ ${investedAmount.toStringAsFixed(0)}", theme),
            _buildResultRow("Est. Returns", "₹ ${expectedReturns.toStringAsFixed(0)}", theme),
            const Divider(height: 32),
            _buildResultRow("Total Value", "₹ ${totalValue.toStringAsFixed(0)}", theme, isBold: true),
          ],
        ),
    );
  }

  Widget _buildResultRow(String label, String value, ThemeData theme, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal
          )),
          Text(value, style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? theme.colorScheme.primary : null,
          )),
        ],
      ),
    );
  }
}
