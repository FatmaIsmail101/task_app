import 'package:flutter/foundation.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:task_essac/core/permission/permissions.dart';

class WifiProvider extends ChangeNotifier {
  List<WiFiAccessPoint> wifiList = [];
  String? selectedWifi;
  bool scanning = false;

  Future<void> scanDevices() async {
    // اطلب الصلاحيات
    await AppPermissions.requestPermission();

    scanning = true;
    notifyListeners();

    try {
      // تحقق إذا ممكن نبدأ Scan
      final can = await WiFiScan.instance.canStartScan();

      if (can == CanStartScan.yes) {
        await WiFiScan.instance.startScan();
      } else {
        scanning = false;
        notifyListeners();
        return;
      }

      // احصل على النتائج
      wifiList = await WiFiScan.instance.getScannedResults();

      scanning = false;
      notifyListeners();
    } catch (e) {
      scanning = false;
      notifyListeners();
    }
  }

  void selectWifi(String ssid) {
    selectedWifi = ssid;
    notifyListeners();
  }
}
