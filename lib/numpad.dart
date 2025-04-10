import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'num_field.dart';

class NumPad extends StatelessWidget {
  const NumPad({super.key});

  Widget _buildButton(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<NumFieldNotifier>().addSymbol(value);
        },
        child: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(context, "1"),
            _buildButton(context, "2"),
            _buildButton(context, "3"),
            Consumer<NumFieldNotifier>(
              builder: (context, numField, child) {
                return _buildButton(context, numField.useLastNumber ? "*" : "+");
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(context, "4"),
            _buildButton(context, "5"),
            _buildButton(context, "6"),
            Consumer<NumFieldNotifier>(
              builder: (context, numField, child) {
                return _buildButton(context, numField.useLastNumber ? ":" : "-");
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(context, "7"),
            _buildButton(context, "8"),
            _buildButton(context, "9"),
            Consumer<NumFieldNotifier>(
              builder: (context, numField, child) {
                return _buildButton(context, numField.useLastNumber ? "^" : "*");
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(width: 80),
            _buildButton(context, "0"),
            _buildButton(context, ","),
            Consumer<NumFieldNotifier>(
              builder: (context, numField, child) {
                return _buildButton(context, numField.useLastNumber ? "√" : ":");
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<NumFieldNotifier>(
              builder: (context, numField, child) {
                return _buildButton(
                    context,
                    numField.useLastNumber ? "More" : "Result");
              },
            ),
            Container(width: 15),
            _buildButton(context, "Erase"),
            Container(width: 15),
            _buildButton(context, "Clear"),
          ],
        )
      ],
    );
  }
}
