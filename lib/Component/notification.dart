// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Notifikasi {
//   final FlutterLocalNotificationsPlugin localNotification =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     const AndroidInitializationSettings androSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iosSettings =
//         DarwinInitializationSettings();

//     const InitializationSettings initSettings =
//         InitializationSettings(android: androSettings, iOS: iosSettings);

//     await localNotification.initialize(initSettings);
//   }

//   void showPesanNotif(String title, String body) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'Pesan',
//       'Notifikasi',
//       channelDescription: 'Item berhasil dijual',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//       icon: '@mipmap/ic_launcher',
//     );

//     const NotificationDetails platDetails =
//         NotificationDetails(android: androidDetails);

//     await localNotification.show(10, title, body, platDetails,
//         payload: 'Not present');
//   }
// }
