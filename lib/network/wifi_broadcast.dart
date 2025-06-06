import 'dart:convert';
import 'dart:io';
import 'package:udp/udp.dart';

class WifiBroadcast {
  static const String _multicastAddress = "239.1.2.3";
  static const int _port = 4567;

  /// Gửi dữ liệu dạng Map (biểu mẫu y lệnh) tới toàn bộ thiết bị trong mạng LAN
  static Future<void> sendForm(Map<String, dynamic> data) async {
    final udp = await UDP.bind(Endpoint.any(port: Port(0)));
    final message = utf8.encode(json.encode(data));

    await udp.send(message, Endpoint.multicast(
      InternetAddress(_multicastAddress),
      port: Port(_port),
    ));

    await udp.close();
  }

  /// Lắng nghe dữ liệu nhận được từ thiết bị khác
  static Future<void> listen(Function(Map<String, dynamic>) onReceived) async {
    final udp = await UDP.bind(
      Endpoint.multicast(
        InternetAddress(_multicastAddress),
        port: Port(_port),
      ),
    );

    udp.asStream().listen((datagram) {
      final str = utf8.decode(datagram?.data ?? []);
      final jsonData = json.decode(str);
      onReceived(jsonData);
    });
  }
}

