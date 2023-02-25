//
// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'authentication_services.dart';
//
// class Imageset extends StatefulWidget {
//   const Imageset({Key? key}) : super(key: key);
//
//   @override
//   State<Imageset> createState() => _ImagesetState();
// }
//
// class _ImagesetState extends State<Imageset> {
//   File? pic;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Column(
//             children: <Widget>[
//               Container(
//
//
//                 decoration: BoxDecoration(image: DecorationImage(image: FileImage(pic!))),
//                 child: Icon(Icons.edit),),
//               TextFormField(),
//               ElevatedButton(onPressed: () {imagecamera();}, child: const Text("add image"))
//             ],
//           )),
//     );
//   }
//
//   imagefun()async{
//     print("ok");
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     File strpath= File(image!.path);
//     setState((){
//
//       pic=strpath;
//     });
//   }
//
//
//   imagecamera()async{
//     print("ok");
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     File strpath= File(image!.path);
//     setState((){
//
//       pic=strpath;
//     });
//     AuthenticationServices.upload_image_firebase(pic!);
//
//
//
//
//   }
//
// }




