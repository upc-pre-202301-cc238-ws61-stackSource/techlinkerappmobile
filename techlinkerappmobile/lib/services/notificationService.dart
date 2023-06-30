import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> initializeNotificationsPlugin() async {
  const initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
    // El usuario ha concedido el permiso de notificación
    print("Permiso de notificación concedido");
  } else if (status.isDenied) {
    // El usuario ha denegado el permiso de notificación
    print("Permiso de notificación denegado");
  } else if (status.isPermanentlyDenied) {
    // El usuario ha denegado permanentemente el permiso de notificación
    print("Permiso de notificación denegado permanentemente");
  }
}
