import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techlinkerappmobile/screens/login.dart';
import 'package:techlinkerappmobile/screens/main_developer_page.dart';
import 'package:techlinkerappmobile/screens/main_company_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:techlinkerappmobile/services/notificationService.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasRequestedPermission = prefs.getBool('hasRequestedPermission') ?? false;

  if (!hasRequestedPermission) {
    await requestNotificationPermission();
    await prefs.setBool('hasRequestedPermission', true);
  }

  await initializeNotificationsPlugin();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Linker',
      //home: LoginPage(),
      home: LoginPage(),
    );
  }
}
