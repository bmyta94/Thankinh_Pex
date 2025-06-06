import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'form_screen.dart'; // import màn hình chính

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
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Chức danh nghề nghiệp'),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'VD: Bác sĩ, Điều dưỡng...',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Họ tên đầy đủ'),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nhập họ tên...',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Chữ ký'),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Signature(
                controller: signatureController,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    signatureController.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
                  );
                  return;
                }

                // Điều hướng sang màn hình phiếu theo dõi PEX
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PexFormScreen(
                      userTitle: titleController.text,
                      userName: nameController.text,
                    ),
                  ),
                );
              },
              child: const Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
