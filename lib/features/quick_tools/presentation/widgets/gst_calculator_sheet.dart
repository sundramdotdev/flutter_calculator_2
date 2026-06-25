import 'package:flutter/material.dart';

class GSTCalculatorSheet extends StatefulWidget {
  const GSTCalculatorSheet({super.key});

  @override
  State<GSTCalculatorSheet> createState() => _GSTCalculatorSheetState();
}

class _GSTCalculatorSheetState extends State<GSTCalculatorSheet> {
  final TextEditingController _amountController = TextEditingController();
  double _gstRate = 18.0;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final gstAmount = (amount * _gstRate) / 100;
    final totalAmount = amount + gstAmount;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Original Amount",
              prefixText: "₹ ",
              border: OutlineInputBorder(),
            ),
            onChanged: (val) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Text("GST Rate", style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<double>(
              segments: const [
                ButtonSegment(value: 5.0, label: Text("5%")),
                ButtonSegment(value: 12.0, label: Text("12%")),
                ButtonSegment(value: 18.0, label: Text("18%")),
                ButtonSegment(value: 28.0, label: Text("28%")),
              ],
              selected: {_gstRate},
              onSelectionChanged: (Set<double> newSelection) {
                setState(() => _gstRate = newSelection.first);
              },
              style: SegmentedButton.styleFrom(
                backgroundColor: theme.colorScheme.surface,
                selectedForegroundColor: theme.colorScheme.onPrimary,
                selectedBackgroundColor: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildResultRow("CGST (${_gstRate/2}%)", "₹ ${(_gstRate > 0 ? gstAmount/2 : 0).toStringAsFixed(2)}", theme),
          _buildResultRow("SGST (${_gstRate/2}%)", "₹ ${(_gstRate > 0 ? gstAmount/2 : 0).toStringAsFixed(2)}", theme),
          const Divider(height: 32),
          _buildResultRow("Total Amount", "₹ ${totalAmount.toStringAsFixed(2)}", theme, isBold: true),
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
