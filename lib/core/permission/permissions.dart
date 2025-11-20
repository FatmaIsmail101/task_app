import 'package:permission_handler/permission_handler.dart';
class AppPermissions{
  static Future<void>requestPermission()async{
    await[
      Permission.location,Permission.bluetooth,Permission.bluetoothScan,
      Permission.bluetoothConnect
    ].request();
  }
  static Future<bool>requestBluetoothPermission()async{
    var scan=await Permission.bluetoothScan.request();
    var connect=await Permission.bluetoothConnect.request();
    var location=await Permission.location.request();
    return scan.isGranted&&connect.isGranted&&location.isGranted;
   }
}