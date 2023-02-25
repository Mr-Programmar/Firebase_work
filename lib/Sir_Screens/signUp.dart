import 'package:flutter/material.dart';


import '../Screens/authentication_services.dart';
import 'authentication_services.dart';

// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});
//   TextEditingController phoneCntl = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               const Text("Number"),
//               TextField(
//                 controller: phoneCntl,
//               ),
//             ],
//           ),
//           ElevatedButton(
//             onPressed: () {
//               AuthenticationServices.verifyPhoneNumber(
//                   context: context, phone: phoneCntl.text.toString());
//             },
//             child: const Text("SingUp"),
//           ),
//         ],
//       ),
//     );
//   }
// }
