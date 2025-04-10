import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'num_field.dart';
import 'numpad.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NumFieldNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Just Calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Consumer<NumFieldNotifier>(
            builder: (context, numField, child) {
              return Text(
                numField.expression,
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 20),
          Consumer<NumFieldNotifier>(
            builder: (context, numField, child) {
              return Text(
                numField.answer,
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const NumPad(),
        ],
      ),
    );
  }
}