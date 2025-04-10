import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

const String symbols = "+-:*^√";
const String numbers = "1234567890";

class NumFieldNotifier with ChangeNotifier {
  String _expression = "";
  String _answer = "";
  late Parser _parser;

  String _lastNumber = "";
  String _lastOperation = "";
  bool _useLastNumber = false;

  NumFieldNotifier() {
    _parser = Parser();
  }

  String get expression => _expression;

  String get answer => _answer;

  bool get useLastNumber => _useLastNumber;

  void addSymbol(String value) {
    if (value == (useLastNumber ? "More" : "Result")) {
      _flush();
      notifyListeners();
    } else if (value == "Clear") {
      _clear();
      notifyListeners();
    } else if (value == "Erase") {
      _answer = "";
      _erase();
      notifyListeners();
    } else {
      if (_answer.isNotEmpty) {
        _answer = "";
      }
      bool handle = true;
      String number = "";

      if (_expression.isEmpty && symbols.contains(value)) {
        if (value == "-" || value == "+") {
          _expression += "0";
        } else {
          _expression += "1";
        }
      } else if (_expression.isNotEmpty &&
          symbols.contains(_expression[_expression.length - 1]) &&
          symbols.contains(value)) {
        handle = false;
      } else {
        String expr = _expression.replaceAll("+", "*");
        expr = expr.replaceAll("-", "*");
        expr = expr.replaceAll(":", "*");
        List<String> numbers = expr.split("*");

        if (numbers.isNotEmpty) {
          number = numbers[numbers.length - 1];
          int count = value == "," ? 1 : 0;
          for (int i = 0; i < number.length; i++) {
            if (number[i] == ",") {
              count++;
            }
            if (count > 1) {
              handle = false;
              break;
            }
          }
          number += value;
        }
      }

      if (handle || numbers.contains(value)) {
        if (symbols.contains(value)) {
          _lastOperation = value;
          _useLastNumber = false;
        }
        _lastNumber = number;

        _expression += value;
        _calculate();
        notifyListeners();
      }
    }
  }

  void _flush() {
    if (_useLastNumber) {
      _expression += _lastOperation + _lastNumber;
      _calculate();
    }
    _useLastNumber =
        _answer != "Error"
            && _lastOperation != "";
    _expression = _answer;
    _answer = "";
  }

  void _calculate() {
    try {
      Expression exp = _parser.parse(_expression.replaceAll(':', '/').replaceAll(',', '.'));
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      _answer = result.toStringAsFixed(14).replaceAll(RegExp(r'\.?0+$'), '');
    } catch (e) {
      _answer = "Error";
    }
  }

  void _erase() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      _lastOperation = "";
      _useLastNumber = false;
    }
  }

  void _clear() {
    _expression = "";
    _answer = "";
    _lastOperation = "";
    _useLastNumber = false;
  }
}
