import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techlinkerappmobile/screens/login.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const MyApp());
}
Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();
  if (status.isDenied) {
    // El usuario ha denegado los permisos de notificación
    print('El usuario ha denegado los permisos de notificación');
    // Puedes mostrar un mensaje o realizar alguna acción adicional aquí
  } else if (status.isPermanentlyDenied) {
    // El usuario ha denegado permanentemente los permisos de notificación
    print('El usuario ha denegado permanentemente los permisos de notificación');
    // Puedes mostrar un mensaje y guiar al usuario a la configuración de la aplicación para habilitar los permisos manualmente
    openAppSettings();
  } else if (status.isGranted) {
    // Los permisos de notificación han sido concedidos
    print('Los permisos de notificación han sido concedidos');
    // Puedes continuar con la lógica de tu aplicación relacionada con las notificaciones aquí
    // Por ejemplo, enviar una notificación de prueba
  }
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
