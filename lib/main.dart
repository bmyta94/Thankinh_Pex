import 'package:flutter/material.dart';

void main() {
  runApp(const ThankinhPexApp());
}

class ThankinhPexApp extends StatelessWidget {
  const ThankinhPexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thankinh PEX',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theo dõi PEX')),
      body: const Center(
        child: Text('Ứng dụng theo dõi điều trị thay huyết tương'),
      ),
    );
  }
}
