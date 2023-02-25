// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class FCMServices {

//sub fire base ki apni apni hoti ha fcm server key

  static var fcmServerKey =
      'AAAA-SuU8kE:APA91bFT1OC_rrKYl158iRNWIQ4NwJ_Mbxv-fd9TVPjNAO1Qj-j9OBx61MdowYRj2fOi_uRHQeAO4nfRXq3345kFlumKyrQlVBwC9uXwGpq1wHCvDynIhDMmcjW9ja5RXkuVKg8ouJYP';

//  get device token
  static generateFCMDeviceToken() {
    try {
      FirebaseMessaging.instance.getToken().then((value) {
        print("Device Token: $value");
      });
    } catch (e) {
      print("Device Token e: $e");
    }
  }

  static subscribleToChannel(topic){
    FirebaseMessaging.instance.subscribeToTopic("$topic");
  }

  static unSubscribleToChannel(topic){
    FirebaseMessaging.instance.unsubscribeFromTopic("$topic");
  }
// listen onApp FCM
  static listenAppFCM() {
    FirebaseMessaging.onMessage.listen((event) {
      print("OnApp FCM : $event");

      String title = event.notification!.title.toString();
      String body = event.notification!.body.toString();

      print(title);
      print(body);

      print(event.data);
      displyNotification(title: title.toString(), body: body.toString());
      // FirebaseMessaging.onMessageOpenedApp
    });
  }

  // listen background FCM

  static listenbackgroundFCM(RemoteMessage message) {
    print("FCM background message");

    var title = message.notification!.title;
    var body = message.notification!.body;
    displyNotification(title: title.toString(), body: body.toString());
  }

  // createLocalNotificaion()
  static displyNotification({required String title, required String body}) async{
    print("************************_______________________________________****************************************");

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

  await  flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ));

    flutterLocalNotificationsPlugin.show(
      1,
      "$title",
      "$body",
      NotificationDetails(
          android: AndroidNotificationDetails(
        "test",
        "test",      playSound: true,
            priority: Priority.high,
            importance: Importance.high,
            enableVibration: true,

      )),
    );
  }

  static sendFCMNotification({required to, required title, required body}) async {
    final responce = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$fcmServerKey'
      },
      body: jsonEncode({
        'to': '$to',
        'notification': {
          'title': '$title',
          'body': '$body',
        }
      }),
    );

    print(responce.statusCode);
    print(responce.body);
  }
}
