import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'App_Home_Screen.dart';
import 'authentication_services.dart';
import 'createaccount.dart';

class Appmain extends StatefulWidget {
  const Appmain({Key? key}) : super(key: key);

  @override
  State<Appmain> createState() => _AppmainState();
}

class _AppmainState extends State<Appmain> {

  TextEditingController emailController = TextEditingController();
  TextEditingController pass = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireBase_APP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is Required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pass,
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
                validator: ((value) {
                  RegExp regex = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if (value == null || value.isEmpty) {
                    {
                      return "Password is Required";
                    }
                  } else if (value.length < 6) {
                    return "Passward should greater then 6 char";
                  } else if (value.length > 12) {
                    return "Password should be less then 12 char";
                  } else if (!regex.hasMatch(value)) {
                    return "Password must be strong, use special Char";
                  }
                  return null;
                }),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  child: Text("Sign in"),
                  onPressed: () {
                    AuthenticationServices.login(context: context, email: emailController.text.toString() , password: pass.text.toString());

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppHome(),));
                    },

                  ),

              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccount(),));

                  },
                  child: const Text("signup")),
            ],
          ),
        ),
      ),
    );
  }
  }

