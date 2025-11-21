import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:task_essac/core/permission/permissions.dart';

class BlueToothProvider extends ChangeNotifier {
  bool isScanning = false;
  List<BluetoothDevice> bluetoothDevices = [];
  BluetoothDevice? selectedBluetooth;

  Future<void> scanDevices() async {
    try {
      await AppPermissions.requestBluetoothPermission();
      isScanning = true;
      bluetoothDevices.clear();
      notifyListeners();

      FlutterBluePlus.startScan(timeout: Duration(seconds: 2));

      FlutterBluePlus.scanResults.listen((results) {
        bluetoothDevices = results.map((r) => r.device).toSet().toList();
        notifyListeners();
      });

      FlutterBluePlus.isScanning.listen((event) {
        isScanning = event;
        notifyListeners();
      });
    } catch (e) {
      isScanning = false;
      notifyListeners();
      print('Bluetooth Scan Error: $e');
    }
  }

  void selectBluetooth(BluetoothDevice device) {
    selectedBluetooth = device;
    notifyListeners();
  }
}
