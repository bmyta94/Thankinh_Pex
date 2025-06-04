import 'dart:convert';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:flutter/material.dart';

class WifiService {
  final Strategy strategy = Strategy.P2P_CLUSTER;
  final Map<String, ConnectionInfo> connectedDevices = {};

  Future<void> startAdvertising(String userName, Function(String, String) onReceive) async {
    bool advertisingStarted = await Nearby().startAdvertising(
      userName,
      strategy,
      onConnectionInitiated: (id, info) {
        Nearby().acceptConnection(
          id,
          onPayLoadReceived: (endpointId, payload) {
            if (payload.type == PayloadType.BYTES) {
              String message = utf8.decode(payload.bytes!);
              onReceive(endpointId, message);
            }
          },
          onPayloadTransferUpdate: (endpointId, update) {},
        );
      },
      onConnectionResult: (id, status) {
        if (status == Status.CONNECTED) {
          connectedDevices[id] = ConnectionInfo(endpointName: id, authenticationToken: '', isIncomingConnection: true);
        }
      },
      onDisconnected: (id) {
        connectedDevices.remove(id);
      },
    );
    debugPrint('Advertising started: $advertisingStarted');
  }

  Future<void> startDiscovery(Function(String, String) onReceive) async {
    bool discoveryStarted = await Nearby().startDiscovery(
      "receiver_device",
      strategy,
      onEndpointFound: (id, name, serviceId) {
        Nearby().requestConnection(
          "receiver_device",
          id,
          onConnectionInitiated: (id, info) {
            Nearby().acceptConnection(
              id,
              onPayLoadReceived: (endpointId, payload) {
                if (payload.type == PayloadType.BYTES) {
                  String message = utf8.decode(payload.bytes!);
                  onReceive(endpointId, message);
                }
              },
              onPayloadTransferUpdate: (endpointId, update) {},
            );
          },
          onConnectionResult: (id, status) {
            if (status == Status.CONNECTED) {
              debugPrint("Connected to $id");
            }
          },
          onDisconnected: (id) {
            debugPrint("Disconnected from $id");
          },
        );
      },
      onEndpointLost: (id) {
        debugPrint("Endpoint lost: $id");
      },
    );
    debugPrint('Discovery started: $discoveryStarted');
  }

  Future<void> sendMessage(String endpointId, String message) async {
    final bytes = utf8.encode(message);
    final payload = Payload.fromBytes(bytes);
    await Nearby().sendPayload(endpointId, payload);
  }

  void stopAll() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
    Nearby().stopAllEndpoints();
  }
}
