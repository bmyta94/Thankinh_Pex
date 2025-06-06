import 'package:nearby_connections/nearby_connections.dart';

class WifiService {
  final Strategy strategy = Strategy.P2P_CLUSTER;

  void startAdvertising(String userName, Function(String id, String data) onDataReceived) async {
    bool advertisingStarted = await Nearby().startAdvertising(
      userName,
      strategy,
      onConnectionInitiated: (id, connectionInfo) {
        Nearby().acceptConnection(id, (payload) {
          if (payload.type == PayloadType.BYTES) {
            final data = String.fromCharCodes(payload.bytes!);
            onDataReceived(id, data);
          }
        });
      },
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
    );
    print("Advertising started: $advertisingStarted");
  }

  void startDiscovery(Function(String id, String data) onDataReceived) async {
    bool discoveringStarted = await Nearby().startDiscovery(
      "Receiver",
      strategy,
      onConnectionInitiated: (id, connectionInfo) {
        Nearby().acceptConnection(id, (payload) {
          if (payload.type == PayloadType.BYTES) {
            final data = String.fromCharCodes(payload.bytes!);
            onDataReceived(id, data);
          }
        });
      },
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
    );
    print("Discovery started: $discoveringStarted");
  }

  void stopAll() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
  }
}
