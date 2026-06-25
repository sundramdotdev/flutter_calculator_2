import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/calculator_engine.dart';
import '../../../../features/history/data/repositories/history_repository.dart';

class CalculatorState extends Equatable {
  final String expression;
  final String result;
  final bool isRadianMode;
  final bool isScientificExpanded;

  const CalculatorState({
    this.expression = "",
    this.result = "",
    this.isRadianMode = false,
    this.isScientificExpanded = false,
  });

  CalculatorState copyWith({
    String? expression,
    String? result,
    bool? isRadianMode,
    bool? isScientificExpanded,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      isRadianMode: isRadianMode ?? this.isRadianMode,
      isScientificExpanded: isScientificExpanded ?? this.isScientificExpanded,
    );
  }

  @override
  List<Object?> get props => [expression, result, isRadianMode, isScientificExpanded];
}

class CalculatorNotifier extends Notifier<CalculatorState> {
  final _historyRepo = HistoryRepository();

  @override
  CalculatorState build() => const CalculatorState();

  void addToken(String token) {
    String currentExpr = state.expression;
    
    if (_isOperator(token)) {
      if (currentExpr.isEmpty && token != '-') return;
      if (currentExpr.isNotEmpty) {
        String lastChar = currentExpr[currentExpr.length - 1];
        if (_isOperator(lastChar)) {
          currentExpr = currentExpr.substring(0, currentExpr.length - 1);
        }
      }
    }

    final newExpr = currentExpr + token;
    final newResult = CalculatorEngine.evaluate(newExpr, isRadianMode: state.isRadianMode);
    
    state = state.copyWith(
      expression: newExpr,
      result: newResult == "Error" ? state.result : newResult,
    );
  }

  void delete() {
    if (state.expression.isEmpty) return;
    
    final newExpr = state.expression.substring(0, state.expression.length - 1);
    final newResult = newExpr.isEmpty ? "" : CalculatorEngine.evaluate(newExpr, isRadianMode: state.isRadianMode);
    
    state = state.copyWith(
      expression: newExpr,
      result: newResult == "Error" ? "" : newResult,
    );
  }

  void clear() {
    state = state.copyWith(expression: "", result: "");
  }

  void calculate() {
    if (state.expression.isEmpty) return;
    final res = CalculatorEngine.evaluate(state.expression, isRadianMode: state.isRadianMode);
    if (res != "Error" && res != "Cannot divide by zero") {
      // Save calculation to history
      _historyRepo.saveCalculation(state.expression, res);

      state = state.copyWith(
        expression: res,
        result: "",
      );
    } else {
      state = state.copyWith(result: res);
    }
  }

  void toggleAngleMode() {
    state = state.copyWith(isRadianMode: !state.isRadianMode);
    _recalculate();
  }

  void toggleScientificMode() {
    state = state.copyWith(isScientificExpanded: !state.isScientificExpanded);
  }

  void loadFromHistory(String expression) {
    state = state.copyWith(expression: expression, result: "");
    _recalculate();
  }

  void _recalculate() {
    if (state.expression.isEmpty) return;
    final newResult = CalculatorEngine.evaluate(state.expression, isRadianMode: state.isRadianMode);
    state = state.copyWith(
      result: newResult == "Error" ? "" : newResult,
    );
  }

  bool _isOperator(String str) {
    return ['+', '-', '×', '÷', '%', '^'].contains(str);
  }
}

final calculatorProvider = NotifierProvider<CalculatorNotifier, CalculatorState>(
  () => CalculatorNotifier(),
);
