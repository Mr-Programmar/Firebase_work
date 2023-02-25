import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_work/Screens/Add_item_Screen.dart';
import 'package:flutter/material.dart';

import 'Screens/App_Start_Screen.dart';
import 'Screens/Fire_base_image.dart';
import 'Screens/Phone_varify.dart';
import 'Screens/createaccount.dart';
import 'Sir_Screens/Sie_home-2.dart';
import 'Screens/home-3.dart';
import 'Sir_Screens/fcm_Services-1.dart';
import 'Sir_Screens/signUp.dart';



void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMServices.generateFCMDeviceToken();
  FCMServices.listenAppFCM();
  FirebaseMessaging.onBackgroundMessage((message) => FCMServices.listenbackgroundFCM(message));
  FCMServices.subscribleToChannel("manager");
  FCMServices.unSubscribleToChannel("user");
  FCMServices.unSubscribleToChannel("staff");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const Add(),
    );
  }
}

