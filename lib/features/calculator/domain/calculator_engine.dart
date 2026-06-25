import 'dart:math' as math;
import 'package:decimal/decimal.dart';

class CalculatorEngine {
  static final RegExp _tokenizerRegex = RegExp(r'(sin|cos|tan|log|ln|sqrt|pi|e|\d+\.?\d*|\.\d+|[+\-×÷%()*/^])');

  static String evaluate(String expression, {bool isRadianMode = false}) {
    if (expression.isEmpty) return "";
    try {
      // Normalize operators
      String normalized = expression.replaceAll('×', '*').replaceAll('÷', '/');
      List<String> tokens = _tokenize(normalized);
      if (tokens.isEmpty) return "";
      
      List<String> postfix = _shuntingYard(tokens);
      Decimal result = _evaluatePostfix(postfix, isRadianMode);
      
      return _formatResult(result);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains("Division by zero")) return "Cannot divide by zero";
      if (msg.contains("NaN")) return "Error";
      if (msg.contains("Too large") || msg.contains("Infinity")) return "Too large";
      return "Error";
    }
  }

  static List<String> _tokenize(String expr) {
    List<String> tokens = [];
    final matches = _tokenizerRegex.allMatches(expr);
    for (var match in matches) {
      tokens.add(match.group(0)!);
    }
    
    // Handle negative numbers and implicit multiplication
    List<String> processed = [];
    for (int i = 0; i < tokens.length; i++) {
      String t = tokens[i];
      
      // Unary minus
      if (t == '-') {
        if (i == 0 || tokens[i - 1] == '(' || _isOperator(tokens[i - 1])) {
          if (i + 1 < tokens.length && (_isNumber(tokens[i + 1]) || _isConstant(tokens[i+1]))) {
            processed.add('-${tokens[i + 1]}');
            i++; 
            continue;
          } else if (i + 1 < tokens.length && (tokens[i+1] == '(' || _isFunction(tokens[i+1]))) {
            processed.add('-1');
            processed.add('*');
            continue;
          }
        }
      }
      
      // Implicit multiplication logic
      if (processed.isNotEmpty) {
        String prev = processed.last;
        if ((_isNumber(prev) || _isConstant(prev) || prev == ')') && 
            (_isFunction(t) || _isConstant(t) || t == '(')) {
          processed.add('*');
        }
      }

      processed.add(t);
    }
    return processed;
  }

  static bool _isNumber(String str) {
    return double.tryParse(str) != null && str != 'e'; 
  }

  static bool _isConstant(String str) {
    return str == 'pi' || str == 'e';
  }

  static bool _isFunction(String str) {
    return ['sin', 'cos', 'tan', 'log', 'ln', 'sqrt'].contains(str);
  }

  static bool _isOperator(String str) {
    return ['+', '-', '*', '/', '%', '^'].contains(str);
  }

  static int _precedence(String op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/' || op == '%') return 2;
    if (op == '^') return 3;
    if (_isFunction(op)) return 4;
    return 0;
  }

  static List<String> _shuntingYard(List<String> tokens) {
    List<String> output = [];
    List<String> operators = [];

    for (String token in tokens) {
      if (_isNumber(token) || _isConstant(token)) {
        output.add(token);
      } else if (_isFunction(token)) {
        operators.add(token);
      } else if (token == '(') {
        operators.add(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          output.add(operators.removeLast());
        }
        if (operators.isNotEmpty && operators.last == '(') {
          operators.removeLast();
        }
        if (operators.isNotEmpty && _isFunction(operators.last)) {
          output.add(operators.removeLast());
        }
      } else if (_isOperator(token)) {
        int assoc = (token == '^') ? 1 : 0; 
        while (operators.isNotEmpty && 
               operators.last != '(' && 
               (_precedence(operators.last) > _precedence(token) || 
               (_precedence(operators.last) == _precedence(token) && assoc == 0))) {
          output.add(operators.removeLast());
        }
        operators.add(token);
      }
    }

    while (operators.isNotEmpty) {
      output.add(operators.removeLast());
    }

    return output;
  }

  static Decimal _evaluatePostfix(List<String> postfix, bool isRadianMode) {
    List<Decimal> stack = [];

    for (String token in postfix) {
      if (_isNumber(token)) {
        stack.add(Decimal.parse(token));
      } else if (_isConstant(token)) {
        if (token == 'pi') stack.add(Decimal.parse(math.pi.toString()));
        if (token == 'e') stack.add(Decimal.parse(math.e.toString()));
      } else if (_isFunction(token)) {
        if (stack.isEmpty) throw Exception("Invalid expression");
        Decimal a = stack.removeLast();
        double val = a.toDouble();
        double result = 0.0;

        switch (token) {
          case 'sin':
            result = math.sin(isRadianMode ? val : val * math.pi / 180.0);
            break;
          case 'cos':
            result = math.cos(isRadianMode ? val : val * math.pi / 180.0);
            break;
          case 'tan':
            result = math.tan(isRadianMode ? val : val * math.pi / 180.0);
            break;
          case 'log':
            result = math.log(val) / math.ln10; 
            break;
          case 'ln':
            result = math.log(val); 
            break;
          case 'sqrt':
            if (val < 0) throw Exception("Error");
            result = math.sqrt(val);
            break;
        }
        if (result.isNaN) throw Exception("NaN");
        if (result.isInfinite) throw Exception("Too large");
        if (result.abs() < 1e-10) result = 0.0;
        
        // Remove trailing non-precision decimals from floating string conversion
        String resStr = result.toString();
        stack.add(Decimal.parse(resStr));
      } else if (_isOperator(token)) {
        if (stack.length < 2) throw Exception("Invalid expression");
        Decimal b = stack.removeLast();
        Decimal a = stack.removeLast();
        
        switch (token) {
          case '+':
            stack.add(a + b);
            break;
          case '-':
            stack.add(a - b);
            break;
          case '*':
            stack.add(a * b);
            break;
          case '/':
            if (b == Decimal.zero) throw Exception("Division by zero");
            final rationalResult = a.toRational() / b.toRational();
            stack.add(rationalResult.toDecimal(scaleOnInfinitePrecision: 10));
            break;
          case '%':
            if (b == Decimal.zero) throw Exception("Division by zero");
            stack.add(a % b);
            break;
          case '^':
            final double res = math.pow(a.toDouble(), b.toDouble()).toDouble();
            if (res.isNaN) throw Exception("NaN");
            if (res.isInfinite) throw Exception("Too large");
            stack.add(Decimal.parse(res.toString()));
            break;
        }
      }
    }

    if (stack.length != 1) throw Exception("Invalid expression");
    return stack.first;
  }

  static String _formatResult(Decimal result) {
    String str = result.toString();
    if (str.contains('.')) {
      str = str.replaceAll(RegExp(r'0*$'), '');
      if (str.endsWith('.')) {
        str = str.substring(0, str.length - 1);
      }
    }
    return str;
  }
}
