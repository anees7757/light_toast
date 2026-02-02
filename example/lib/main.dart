import 'package:flutter/material.dart';
import 'package:light_toast/light_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Toast.navigatorKey,
      home: Scaffold(
        appBar: AppBar(title: const Text('Toast Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Toast.show('Hello, Flutter!');
            },
            child: const Text('Show Toast'),
          ),
        ),
      ),
    );
  }
}
