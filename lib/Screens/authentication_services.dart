// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print



import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../app_toast.dart';
import 'App_Home_Screen.dart';


class AuthenticationServices {
  static signUp(
      {required BuildContext context,
      required email,
      required password}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


    } on FirebaseAuthException catch (e) {
      if (e.code == "unknown") {
        print("Some fild miss please double check");
      } else if (e.code == "invalid-email") {
        print("Your email format is not correct please try again");
      } else if (e.code == "weak-password") {
        print("Password should be greater then 6 digit");
      } else if (e.code == "email-already-in-use") {
        print("Your email already exist please try another email");
      }
      print("Firebase e $e");
    } catch (e) {
      print("e $e");
    }
  }

  static login({required context, required email, required password}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AppHome()));
      AppToast.successToast(masg: "SingUp Success!");
      print("Login Success!");
    } on FirebaseAuthException catch (e) {
      print("Firebae Auth $e");
      if (e.code == "wrong-password") {
        AppToast.failToast(masg: "Your Password is Wrong Please try again");
      } else if (e.code == "user-not-found") {
        AppToast.failToast(masg: "Email not Found Please try again");
      }
    } catch (e) {
      print(e);
    }
  }

  static saveUserData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection("users").doc().set({
      'name':  "name",
      'email': "emailcontroller",
      'phone': "phone",
      'passrod': "passcontroller",
    });
  }

  static logout() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
  }

  static phonevarify( {required BuildContext context, required String rcv_num}) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
        verificationCompleted: (e) {
          print(e);
        },
        verificationFailed: (e) {
          print(e);
        },
        codeSent: (String? rcv_code, int? token) {

        },
        codeAutoRetrievalTimeout: (e) {
          print(e);
        },
        phoneNumber: rcv_num,



    );
  }



//  static upload_image_firebase(  File phone_image)async{
//    print("hiiittttt");
//
//   FirebaseStorage obj=FirebaseStorage.instance;
//   Reference reference=obj.ref("foldername");
//   UploadTask upload=reference.putFile(phone_image);
//
//   await Future.value(upload);
//   print("upload Done");
// }

  static verifyOTP({required verficationId, required otp}) async {
    try {
      print("verify Otp.....");
      FirebaseAuth auth = FirebaseAuth.instance;

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationId,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential).then((value) {
        print("OTP  Verify Succes");

      }).catchError((e) {
        print("Catch E: $e");
      });
    } catch (e) {
      print("#e");
    }
  }



}
