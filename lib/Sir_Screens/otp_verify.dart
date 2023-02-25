import 'package:flutter/material.dart';

import '../Screens/authentication_services.dart';
import 'authentication_services.dart';


// class Otpverify extends StatelessWidget {
//   String verificationId;
//   Otpverify({required this.verificationId});
//   TextEditingController otpCntl = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("OTP Verify"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               const Text("OTP"),
//               TextField(
//                 controller: otpCntl,
//               ),
//             ],
//           ),
//           ElevatedButton(
//             onPressed: () {
//               AuthenticationServices.verifyOTP(
//                 verficationId: verificationId,
//                 otp: otpCntl.text.toString(),
//               );
//             },
//             child: const Text("Verify"),
//           ),
//         ],
//       ),
//     );
//   }
// }
