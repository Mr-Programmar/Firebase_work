

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../Sir_Screens/add_item.dart';
import 'App_Home_Screen.dart';
import 'Verfiy_code_screen.dart';
import 'authentication_services.dart';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: "TYPE YOUR EMAIL"),
                controller: emailcontroller,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: "TYPE YOUR PASS"),
                controller: passcontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: ("Name"),
                  )),
              TextFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(), hintText: "Phone_num"),
                controller: phone,
              ),
              ElevatedButton(onPressed: () {
                AuthenticationServices.signUp(
                    context: context,
                    email: emailcontroller.text.toString(),
                    password: passcontroller.text.toString());
                savefirestore();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppHome(),));



              }, child: Text("Create")),
              InkWell(
                    onTap: () {

                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 150,
                      decoration: image == null
                          ? const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                              image: DecorationImage(
                                image: AssetImage('assets/download.jpg'),
                              ))
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(image!),
                              )),
                    ),
                  ),

            ],
          ),
        ),
      ),
    );
  }

  savefirestore(){
    FirebaseFirestore asad=FirebaseFirestore.instance;
    asad.collection("user_signup_record").doc().set({

      'name':name.text.toString(),
      'phone':phone.text.toString(),
      'email':emailcontroller.text.toString(),
    'passrod':passcontroller.text.toString(),


    });
  }
  static pickerBottomSheet( context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(Icons.camera),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // pickGalleryImage();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(Icons.image),
                  ),
                ),
              ],
            ),
          );
        });
  }





}

