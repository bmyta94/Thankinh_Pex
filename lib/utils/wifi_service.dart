import 'package:nearby_connections/nearby_connections.dart';

class WifiService {
  final Strategy strategy = Strategy.P2P_CLUSTER;

  void startAdvertising(String userName, Function(String id, String data) onDataReceived) {
    Nearby().startAdvertising(
      userName,
      strategy,
      onConnectionInitiated: (id, connectionInfo) {
        Nearby().acceptConnection(
          id,
          (endpointId, payload) {
            final data = String.fromCharCodes(payload.bytes!);
            onDataReceived(endpointId, data);
          },
        );
      },
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
    );
  }

  void startDiscovery(Function(String id, String data) onDataReceived) {
    Nearby().startDiscovery(
      "Receiver",
      strategy,
      onConnectionInitiated: (id, connectionInfo) {
        Nearby().acceptConnection(
          id,
          (endpointId, payload) {
            final data = String.fromCharCodes(payload.bytes!);
            onDataReceived(endpointId, data);
          },
        );
      },
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
    );
  }

  void stopAll() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
  }
}
