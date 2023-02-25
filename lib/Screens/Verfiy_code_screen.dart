// import 'package:firebase_work/Screens/Add_item_Screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'App_Home_Screen.dart';
// import 'authentication_services.dart';
//
// class Codevarify extends StatefulWidget {
//   const Codevarify({Key? key}) : super(key: key);
//
//   @override
//   State<Codevarify> createState() => _CodevarifyState();
// }
//
// class _CodevarifyState extends State<Codevarify> {
//   TextEditingController otp = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(body: Column(
//         children: [
//           Container(
//
//             child: TextFormField(
//               decoration: InputDecoration(hintText: "Enter phone otp"),
//
//               controller: otp,
//             ),
//           ),
//           ElevatedButton(
//
//
//               onPressed: () {
//
//
//                 AuthenticationServices.verifyOTP(verficationId: verficationId, otp: otp.text);
//
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppHome(),));
//
//               },
//               child: const Text("Done")),
//         ],
//       )),
//     );
//   }
// }
