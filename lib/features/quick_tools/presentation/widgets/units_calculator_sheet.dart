import 'package:flutter/material.dart';

class UnitsCalculatorSheet extends StatefulWidget {
  const UnitsCalculatorSheet({super.key});

  @override
  State<UnitsCalculatorSheet> createState() => _UnitsCalculatorSheetState();
}

class _UnitsCalculatorSheetState extends State<UnitsCalculatorSheet> {
  final TextEditingController _inputController = TextEditingController();

  String _category = "Length";
  String _fromUnit = "Meters";
  String _toUnit = "Kilometers";

  final Map<String, List<String>> _categories = {
    "Length": ["Meters", "Kilometers", "Miles", "Feet", "Centimeters", "Inches"],
    "Weight": ["Kilograms", "Grams", "Pounds", "Ounces"],
    "Temperature": ["Celsius", "Fahrenheit", "Kelvin"],
  };

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  double _convert() {
    final val = double.tryParse(_inputController.text) ?? 0.0;
    if (_fromUnit == _toUnit) return val;

    // Length to Meters
    double inMeters = val;
    if (_category == "Length") {
      switch (_fromUnit) {
        case "Kilometers": inMeters = val * 1000; break;
        case "Miles": inMeters = val * 1609.344; break;
        case "Feet": inMeters = val * 0.3048; break;
        case "Centimeters": inMeters = val / 100; break;
        case "Inches": inMeters = val * 0.0254; break;
      }
      switch (_toUnit) {
        case "Meters": return inMeters;
        case "Kilometers": return inMeters / 1000;
        case "Miles": return inMeters / 1609.344;
        case "Feet": return inMeters / 0.3048;
        case "Centimeters": return inMeters * 100;
        case "Inches": return inMeters / 0.0254;
      }
    }

    // Weight to Kilograms
    double inKg = val;
    if (_category == "Weight") {
      switch (_fromUnit) {
        case "Grams": inKg = val / 1000; break;
        case "Pounds": inKg = val * 0.453592; break;
        case "Ounces": inKg = val * 0.0283495; break;
      }
      switch (_toUnit) {
        case "Kilograms": return inKg;
        case "Grams": return inKg * 1000;
        case "Pounds": return inKg / 0.453592;
        case "Ounces": return inKg / 0.0283495;
      }
    }

    // Temperature
    if (_category == "Temperature") {
      double inCelsius = val;
      if (_fromUnit == "Fahrenheit") {
        inCelsius = (val - 32) * 5 / 9;
      } else if (_fromUnit == "Kelvin") {
        inCelsius = val - 273.15;
      }

      if (_toUnit == "Celsius") return inCelsius;
      if (_toUnit == "Fahrenheit") return (inCelsius * 9 / 5) + 32;
      if (_toUnit == "Kelvin") return inCelsius + 273.15;
    }

    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = _convert();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            DropdownButtonFormField<String>(
              key: ValueKey(_category),
              initialValue: _category,
              decoration: const InputDecoration(labelText: "Category", border: OutlineInputBorder()),
              items: _categories.keys.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _category = val;
                    _fromUnit = _categories[val]!.first;
                    _toUnit = _categories[val]!.last;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    key: ValueKey(_fromUnit),
                    initialValue: _fromUnit,
                    decoration: const InputDecoration(labelText: "From", border: OutlineInputBorder()),
                    isExpanded: true,
                    items: _categories[_category]!.map((unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _fromUnit = val);
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.swap_horiz),
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    key: ValueKey(_toUnit),
                    initialValue: _toUnit,
                    decoration: const InputDecoration(labelText: "To", border: OutlineInputBorder()),
                    isExpanded: true,
                    items: _categories[_category]!.map((unit) {
                      return DropdownMenuItem(value: unit, child: Text(unit));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _toUnit = val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Value",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                result == result.truncateToDouble() 
                    ? result.toStringAsFixed(0) 
                    : result.toStringAsFixed(4).replaceAll(RegExp(r"0*$"), ""),
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                _toUnit,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
        ),
    );
  }
}
