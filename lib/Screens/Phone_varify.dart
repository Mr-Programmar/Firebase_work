
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'authentication_services.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController stor_num=TextEditingController();
  TextEditingController otp=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Number"),

                controller: stor_num,
              ),
              ElevatedButton(onPressed: (){


              }, child: Text("add")),

              TextFormField(
                decoration: InputDecoration(hintText: "Enter otp"),

                controller: otp,
              ),
              ElevatedButton(onPressed: (){}, child: Text("Done")),
            ],
          ),
        ),
      ),
    );
  }
}
