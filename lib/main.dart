import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/create_ylenh_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theo dõi PEX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      routes: {
        '/tao-ylenh': (context) => const CreateYLenhScreen(),
      },
    );
  }
}
