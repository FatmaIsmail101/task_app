import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:task_essac/core/permission/permissions.dart';
class BlueToothProvider extends ChangeNotifier{
  bool isScanning=false;
  List<BluetoothDevice>bluetoothDevices=[];
  BluetoothDevice?selectedBluetooth;

  Future<void>scanDevices()async{
    await AppPermissions.requestBluetoothPermission();
    isScanning=true;
    notifyListeners();
    try{
      final flutterBluetooth=FlutterBluePlus.startScan(timeout: Duration(seconds: 2));

      FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
      FlutterBluePlus.scanResults.listen((results) {
      final  bluetoothDevices = results.map((r) => r.device).toSet().toList();

        notifyListeners();
      });
      FlutterBluePlus.stopScan();

    }
    catch(_){
       isScanning=false;
       notifyListeners();
    }
  }
  void selectBluetooth(BluetoothDevice device) {
    selectedBluetooth = device;
    notifyListeners();
  }
}
