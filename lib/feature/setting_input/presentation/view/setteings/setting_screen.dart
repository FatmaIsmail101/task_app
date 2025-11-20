import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_essac/core/notification/notification.dart';
import 'package:task_essac/core/permission/permissions.dart';
import 'package:task_essac/core/routes/route_name.dart';
import 'package:task_essac/feature/setting_input/presentation/view_model/bluetooth_provider.dart';
import 'package:task_essac/feature/setting_input/presentation/view_model/input_provider.dart';

import '../../../../../core/reusable_widget/buttons.dart';
import '../../../../../core/reusable_widget/custom_text_form_field.dart';
import '../../../../../core/size_screen/size_config.dart';
import '../../view_model/wifi_provider.dart';

class SettingScreen extends StatelessWidget {
  final TextEditingController urlController = TextEditingController();

  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = context.watch<InputProvider>();
    final wifi = context.watch<WifiProvider>();
    final bluetooth = context.watch<BlueToothProvider>();

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // URL INPUT
                TextFormField(
                  controller: urlController,
                  decoration: InputDecoration(labelText: "Enter URL"),
                  onChanged: (value) =>
                      context.read<InputProvider>().setUrl(value),
                ),

                SizedBox(height: SizeConfig.heightRatio(20)),

                // SELECT URL BUTTON
                ElevatedButton(
                  onPressed: () {
                    context.read<InputProvider>().setUrl(urlController.text);
                    Navigator.pushNamed(context, RouteName.webScreen,arguments: urlController.text);
                  },
                  child: Text("Save URL"),
                ),

                SizedBox(height: 30),

                // WIFI SCAN
                ElevatedButton(
                  onPressed: () => context.read<WifiProvider>().scanDevices(),
                  child: Text("Scan WiFi"),
                ),

                SizedBox(height: 10),

                wifi.wifiList.isNotEmpty
                    ? DropdownButton<String>(
                  hint: Text("Select Wi-Fi"),
                  value: wifi.selectedWifi,
                  items: wifi.wifiList
                      .map((e) => DropdownMenuItem(
                    child: Text(e.ssid),
                    value: e.ssid,
                  ))
                      .toList(),
                  onChanged: (ssid) =>
                      context.read<WifiProvider>().selectWifi(ssid!),
                )
                    : Text("No Wi-Fi Found"),

                SizedBox(height: 30),

                // BLUETOOTH
                ElevatedButton(
                  onPressed: ()async {
                   bool grandted= await AppPermissions.requestBluetoothPermission();
                   if(grandted){
                     context.read<BlueToothProvider>().scanDevices();
                   }
                     else{
                      NotificationBar.showNotification(message: "Bluetooth Permission Dined", type: ContentType.failure,
                          context: context, icon: Icons.error);
                   }

                   },
                  child: Text("Scan Bluetooth"),
                ),

                bluetooth.bluetoothDevices.isNotEmpty
                    ? DropdownButton(
                  value: bluetooth.selectedBluetooth,
                  items: bluetooth.bluetoothDevices
                      .map(
                        (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                          e.advName.isNotEmpty ? e.advName : e.platformName),
                    ),
                  )
                      .toList(),
                  onChanged: (value) =>
                      context.read<BlueToothProvider>().selectBluetooth(value!),
                )
                    : Text("No Bluetooth Devices"),

              ],
            ),
            ),
       );
   }
}
/*
       Expanded(
                child: DropdownMenuItem(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final ssid = wifi.wifiList[index];
                      return ListTile(
                        title: Text("${wifi.wifiList[index]}"),
                        onTap: () {
                          wifi.selectWifi("$ssid");
                        },
                        trailing: wifi.selectedWifi == ssid
                            ? Icon(Icons.access_time)
                            : Icon(Icons.add),
                      );
                    },
                  ),
                ),
              )
 */
