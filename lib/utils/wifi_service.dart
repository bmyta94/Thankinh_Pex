import 'package:nearby_connections/nearby_connections.dart';

class WifiService {
  final Strategy strategy = Strategy.P2P_CLUSTER;

  void startAdvertising(String userName, Function(String id, String data) onDataReceived) async {
    bool advertisingStarted = await Nearby().startAdvertising(
      userName,
      strategy,
      onConnectionInitiated: (id, connectionInfo) {
        Nearby().acceptConnection(id);
      },
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
    );

    if (advertisingStarted) {
      Nearby().setOnPayloadReceivedListener((endpointId, payload) {
        if (payload.type == PayloadType.BYTES) {
          final data = String.fromCharCodes(payload.bytes!);
          onDataReceived(endpointId, data);
        }
      });
    }
  }

  void startDiscovery(Function(String id, String data) onDataReceived) async {
    bool discoveryStarted = await Nearby().startDiscovery(
      "Receiver",
      strategy,
      onConnectionInitiated: (id, connectionInfo) {
        Nearby().acceptConnection(id);
      },
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
    );

    if (discoveryStarted) {
      Nearby().setOnPayloadReceivedListener((endpointId, payload) {
        if (payload.type == PayloadType.BYTES) {
          final data = String.fromCharCodes(payload.bytes!);
          onDataReceived(endpointId, data);
        }
      });
    }
  }

  void stopAll() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
  }
}
