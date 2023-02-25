import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../app_toast.dart';
import 'Add_item_Screen.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home Screen")),


        body: Column(
      children: [
        Text("All users"),

        Expanded(
          child: StreamBuilder(
              stream:
              FirebaseFirestore.instance.collection('user_signup_record').snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.isEmpty
                      ? Text("No Record")
                      : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.docs[index]['name']),
                        subtitle:
                        Text(snapshot.data!.docs[index]['email']),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              ElevatedButton(onPressed: (){}, child: Text("reject")),
                              ElevatedButton(onPressed: (){}, child: Text("acept")),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Text("Some thing wrong");
                }
              })),
        ),


        // ElevatedButton(onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add(),));
        // }, child: Text("Add Item")),
        // ElevatedButton(onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add(),));
        // }, child: Text("Show my Added item")),
        // ElevatedButton(onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add(),));
        // }, child: Text("My favourit items"))

      ],
    ));
  }
}
