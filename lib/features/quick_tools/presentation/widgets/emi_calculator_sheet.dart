import 'package:flutter/material.dart';
import 'dart:math' as math;

class EMICalculatorSheet extends StatefulWidget {
  const EMICalculatorSheet({super.key});

  @override
  State<EMICalculatorSheet> createState() => _EMICalculatorSheetState();
}

class _EMICalculatorSheetState extends State<EMICalculatorSheet> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

  bool _isYears = true;

  @override
  void dispose() {
    _principalController.dispose();
    _rateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final p = double.tryParse(_principalController.text) ?? 0.0;
    final r = double.tryParse(_rateController.text) ?? 0.0;
    final t = double.tryParse(_tenureController.text) ?? 0.0;

    final double months = _isYears ? t * 12 : t;
    final double monthlyRate = r / (12 * 100);

    double emi = 0.0;
    double totalPayable = 0.0;
    double totalInterest = 0.0;

    if (p > 0 && r > 0 && months > 0) {
      emi = (p * monthlyRate * math.pow(1 + monthlyRate, months)) / 
            (math.pow(1 + monthlyRate, months) - 1);
      totalPayable = emi * months;
      totalInterest = totalPayable - p;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            TextField(
              controller: _principalController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Principal Amount",
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
                labelText: "Interest Rate",
                suffixText: "% p.a.",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tenureController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: "Tenure",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 16),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text("Yr")),
                    ButtonSegment(value: false, label: Text("Mo")),
                  ],
                  selected: {_isYears},
                  onSelectionChanged: (set) => setState(() => _isYears = set.first),
                  style: SegmentedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surface,
                    selectedForegroundColor: theme.colorScheme.onPrimary,
                    selectedBackgroundColor: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildResultRow("Monthly EMI", "₹ ${emi.toStringAsFixed(2)}", theme, isBold: true),
            _buildResultRow("Total Interest", "₹ ${totalInterest.toStringAsFixed(2)}", theme),
            _buildResultRow("Total Payable", "₹ ${totalPayable.toStringAsFixed(2)}", theme),
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
