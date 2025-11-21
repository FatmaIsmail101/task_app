import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:task_essac/core/routes/route_name.dart';
import 'package:task_essac/feature/setting_input/presentation/view/setteings/setting_screen.dart';
import 'package:task_essac/feature/setting_input/presentation/view_model/bluetooth_provider.dart';
import 'package:task_essac/feature/setting_input/presentation/view_model/input_provider.dart';
import 'package:task_essac/feature/setting_input/presentation/view_model/wifi_provider.dart';
import 'package:task_essac/feature/social_login/presentation/view/login_screen.dart';
import 'package:task_essac/feature/web_view/web_view_screen.dart';

import 'core/cashing/cashing_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Permission.bluetoothScan.request();
  await Permission.bluetoothConnect.request();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "secure.env");
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final app = InputProvider();
            app.load();
            return app;
          }),
        ChangeNotifierProvider(
            create: (_) {
              final wifi = WifiProvider();
              wifi.scanDevices();
              return wifi;
            }),
        ChangeNotifierProvider(
            create: (_) {
              final bluetooth = BlueToothProvider();
              bluetooth.scanDevices();
              return bluetooth;
            }),

      ],

      child: MyApp()),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialRoute: RouteName.loginScreen,
      routes: {
        RouteName.loginScreen: (context) => LoginScreen(),
       RouteName.settingScreen:(context)=>SettingScreen(),
        RouteName.webScreen:(context)=>WebViewScreen()
      },
    );
  }
}


