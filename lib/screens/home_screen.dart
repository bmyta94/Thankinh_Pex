import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phiếu theo dõi bệnh nhân thay huyết tương'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tao-ylenh');
              },
              child: const Text('Tạo y lệnh'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Danh sách y lệnh:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text("Nguyễn Văn A"),
                      onTap: () {
                        // TODO: Mở y lệnh để theo dõi
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              // TODO: Gửi qua Wi-Fi
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Xác nhận xoá"),
                                  content: const Text("Có chắc chắn muốn xoá y lệnh này không?"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Không"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                      child: const Text("Có"),
                                      onPressed: () {
                                        // TODO: Xoá y lệnh
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
