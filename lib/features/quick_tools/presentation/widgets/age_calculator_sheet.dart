import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeCalculatorSheet extends StatefulWidget {
  const AgeCalculatorSheet({super.key});

  @override
  State<AgeCalculatorSheet> createState() => _AgeCalculatorSheetState();
}

class _AgeCalculatorSheetState extends State<AgeCalculatorSheet> {
  DateTime? _dob;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    int years = 0, months = 0, days = 0;
    int totalMonths = 0, totalDays = 0;

    if (_dob != null) {
      final now = DateTime.now();
      totalDays = now.difference(_dob!).inDays;
      
      int y = now.year - _dob!.year;
      int m = now.month - _dob!.month;
      int d = now.day - _dob!.day;

      if (d < 0) {
        m--;
        final prevMonth = DateTime(now.year, now.month, 0);
        d += prevMonth.day;
      }
      if (m < 0) {
        y--;
        m += 12;
      }
      
      years = y;
      months = m;
      days = d;
      totalMonths = (years * 12) + months;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dob == null ? "Select Date of Birth" : DateFormat.yMMMd().format(_dob!),
                      style: theme.textTheme.bodyLarge,
                    ),
                    Icon(Icons.calendar_today, color: theme.colorScheme.primary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_dob != null) ...[
              Center(
                child: Text(
                  "$years",
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Years",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard("$months", "Months", theme),
                  _buildStatCard("$days", "Days", theme),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Total Months", style: theme.textTheme.labelMedium),
                      const SizedBox(height: 4),
                      Text("$totalMonths", style: theme.textTheme.titleMedium),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Total Days", style: theme.textTheme.labelMedium),
                      const SizedBox(height: 4),
                      Text("$totalDays", style: theme.textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 100),
            ],
          ],
        ),
    );
  }

  Widget _buildStatCard(String value, String label, ThemeData theme) {
    return Column(
      children: [
        Text(value, style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onSurface)),
        Text(label, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
