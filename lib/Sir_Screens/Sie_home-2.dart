// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../app_toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController itemNameController = TextEditingController();

  TextEditingController itemPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          TextField(
            controller: itemNameController,
            decoration: InputDecoration(label: Text("Item Name")),
          ),
          TextField(
            controller: itemPriceController,
            decoration: InputDecoration(label: Text("Item Price")),
          ),
          ElevatedButton(
            onPressed: () {
              try {
                FirebaseFirestore.instance.collection('items').doc().set(
                  {
                    'item': itemNameController.text,
                    'price': itemPriceController.text,
                  },
                );
                itemNameController.clear();
                itemPriceController.clear();
                AppToast.successToast(masg: "Item Save Successfully");
              } catch (e) {
                AppToast.failToast(masg: "items fail");
              }
            },
            child: Text("Add"),
          ),
          Expanded(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.isEmpty
                        ? Text("No Record")
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data!.docs[index]['item']),
                                subtitle:
                                    Text(snapshot.data!.docs[index]['price']),
                                trailing: SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            var docID =
                                                snapshot.data!.docs[index].id;
                                            print(docID);

                                            FirebaseFirestore.instance
                                                .collection('items')
                                                .doc(docID)
                                                .delete();
                                            AppToast.successToast(
                                                masg: "Item Deleted");
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            var docID =
                                                snapshot.data!.docs[index].id;
                                            print(docID);

                                            FirebaseFirestore.instance
                                                .collection('items')
                                                .doc(docID)
                                                .set(
                                              {
                                                'item': "abc",
                                                'price': "90",
                                              },
                                            );
                                            AppToast.successToast(
                                                masg: "Item Update");
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          )),
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
        ],
      ),
    );
  }
}
