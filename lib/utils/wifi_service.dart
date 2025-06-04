import 'package:nearby_connections/nearby_connections.dart';

class WifiService {
  final Strategy strategy = Strategy.P2P_CLUSTER;
  final NearbyService _nearbyService = NearbyService();
  final String userName;

  WifiService({required this.userName});

  Future<void> init(Function(String deviceId, String payload) onReceived) async {
    await _nearbyService.init(
      serviceType: 'pex-sharing',
      deviceName: userName,
      strategy: strategy,
      onConnectionInitiated: (id, info) {
        _nearbyService.acceptConnection(id);
      },
      onConnectionResult: (id, status) {
        // Handle connection result if needed
      },
      onDisconnected: (id) {
        // Handle disconnection
      },
      onPayloadReceived: (id, payload) {
        if (payload.type == PayloadType.BYTES) {
          final String message = String.fromCharCodes(payload.bytes!);
          onReceived(id, message);
        }
      },
    );

    await _nearbyService.startBrowsingForPeers();
    await _nearbyService.startAdvertisingPeer();
  }

  void send(String deviceId, String message) {
    final payload = Payload.fromBytes(message.codeUnits);
    _nearbyService.sendPayload(deviceId, payload);
  }

  Future<void> stop() async {
    await _nearbyService.stopBrowsingForPeers();
    await _nearbyService.stopAdvertisingPeer();
  }

  Stream<DiscoveredEndpoint> get discoveredEndpointsStream =>
      _nearbyService.discoveredEndpoints;
}
