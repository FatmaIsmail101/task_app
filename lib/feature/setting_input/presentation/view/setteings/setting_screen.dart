import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_essac/core/notification/notification.dart';
import 'package:task_essac/core/permission/permissions.dart';
import 'package:task_essac/core/routes/route_name.dart';
import 'package:task_essac/feature/setting_input/presentation/view_model/bluetooth_provider.dart';
import 'package:task_essac/feature/setting_input/presentation/view_model/input_provider.dart';
import '../../../../../core/size_screen/size_config.dart';
import '../../view_model/wifi_provider.dart';

class SettingScreen extends StatelessWidget {
  final TextEditingController urlController = TextEditingController();

  SettingScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final url = context.watch<InputProvider>();
    final wifi = context.watch<WifiProvider>();
    final bluetooth = context.watch<BlueToothProvider>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: SizeConfig.heightRatio(20),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // URL INPUT
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a URL";
                  }

                  final regex = RegExp(
                    r'^(https?:\/\/)?([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})(\/\S*)?$',
                  );

                  if (!regex.hasMatch(value)) {
                    return "Invalid URL format";
                  }

                  return null;
                },
                controller: urlController,
                decoration: InputDecoration(labelText: "Enter URL"),
                onChanged: (value) =>
                    context.read<InputProvider>().setUrl(value),
              ),

              // SELECT URL BUTTON
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<InputProvider>().setUrl(urlController.text);
                    Navigator.pushNamed(
                      context,
                      RouteName.webScreen,
                      arguments: urlController.text,
                    );
                  }
                },
                child: Text("Save URL"),
              ),

              SizedBox(height: SizeConfig.heightRatio(30)),

              // WIFI SCAN
              ElevatedButton(
                onPressed: () => context.read<WifiProvider>().scanDevices(),
                child: Text("Scan WiFi"),
              ),

              SizedBox(height: SizeConfig.heightRatio(10)),

              wifi.wifiList.isNotEmpty
                  ? DropdownButton<String>(
                      hint: Text("Select Wi-Fi"),
                      value: wifi.selectedWifi,
                      items: wifi.wifiList
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e.ssid),
                              value: e.ssid,
                            ),
                          )
                          .toList(),
                      onChanged: (ssid) =>
                          context.read<WifiProvider>().selectWifi(ssid!),
                    )
                  : Text("No Wi-Fi Found"),

              SizedBox(height: SizeConfig.heightRatio(30)),

              // BLUETOOTH
              ElevatedButton(
                onPressed: () async {
                  bool grandted =
                      await AppPermissions.requestBluetoothPermission();
                  if (grandted) {
                    context.read<BlueToothProvider>().scanDevices();
                  } else {
                    NotificationBar.showNotification(
                      message: "Bluetooth Permission Dined",
                      type: ContentType.failure,
                      context: context,
                      icon: Icons.error,
                    );
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
                                e.advName.isNotEmpty
                                    ? e.advName
                                    : e.platformName,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => context
                          .read<BlueToothProvider>()
                          .selectBluetooth(value!),
                    )
                  : Text("No Bluetooth Devices"),
            ],
          ),
        ),
      ),
    );
  }
}
