import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;
import '../utils/wifi_service.dart';

class CreateYLenhScreen extends StatefulWidget {
  const CreateYLenhScreen({super.key});

  @override
  State<CreateYLenhScreen> createState() => _CreateYLenhScreenState();
}

class _CreateYLenhScreenState extends State<CreateYLenhScreen> {
  final TextEditingController tenController = TextEditingController();
  final TextEditingController tuoiController = TextEditingController();
  final TextEditingController gioiTinhController = TextEditingController();
  final TextEditingController quaLocController = TextEditingController();
  final TextEditingController dichLocController = TextEditingController();
  final signatureDoctorKey = GlobalKey<SignatureState>();
  final signatureNurseKey = GlobalKey<SignatureState>();

  WifiService wifi = WifiService();

  @override
  void initState() {
    super.initState();
    wifi.startAdvertising("Sender", (id, data) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã nhận: $data")));
    });
  }

  @override
  void dispose() {
    wifi.stopAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo y lệnh'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thông tin bệnh nhân', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: tenController, decoration: const InputDecoration(labelText: 'Họ tên')),
            TextField(controller: tuoiController, decoration: const InputDecoration(labelText: 'Tuổi')),
            TextField(controller: gioiTinhController, decoration: const InputDecoration(labelText: 'Giới tính')),
            const SizedBox(height: 16),
            const Text('Thông số theo dõi', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: quaLocController, decoration: const InputDecoration(labelText: 'Quả lọc')),
            TextField(controller: dichLocController, decoration: const InputDecoration(labelText: 'Dịch lọc')),
            const SizedBox(height: 16),
            const Text('Ký tên:', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Bác sĩ chỉ định'),
            Container(
              height: 100,
              color: Colors.grey[300],
              child: Signature(
                key: signatureDoctorKey,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Điều dưỡng'),
            Container(
              height: 100,
              color: Colors.grey[300],
              child: Signature(
                key: signatureNurseKey,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  final ten = tenController.text;
                  final tuoi = tuoiController.text;
                  final qua = quaLocController.text;
                  final dich = dichLocController.text;
                  final message = 'Y lệnh: $ten, $tuoi tuổi, Quả lọc: $qua, Dịch lọc: $dich';

                  wifi.startDiscovery((id, data) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nhận từ $id: $data")));
                  });

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đang tìm thiết bị...")));
                },
                icon: const Icon(Icons.send),
                label: const Text('Gửi y lệnh'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
