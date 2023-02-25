// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_toast.dart';


class Day3 extends StatefulWidget {
  const Day3({super.key});

  @override
  State<Day3> createState() => _Day3State();
}

class _Day3State extends State<Day3> {
  TextEditingController itemNameController = TextEditingController();

  TextEditingController itemPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
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
                var uid = FirebaseAuth.instance.currentUser!.uid;
                print("UId:  $uid");
                FirebaseFirestore.instance.collection('items').doc().set(
                  {
                    'item': itemNameController.text,
                    'price': itemPriceController.text,
                    'uid': uid,
                    'favorite': false,
                  },
                );
                itemNameController.clear();
                itemPriceController.clear();
                AppToast.successToast(masg: "Item Save Successfully");
              } catch (e) {
                AppToast.failToast(masg: "items failch");
              }
            },
            child: Text("Add"),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
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
                                      IconButton(
                                          onPressed: () {
                                            var docID =
                                                snapshot.data!.docs[index].id;
                                            print(docID);
                                            FirebaseFirestore.instance
                                                .collection('items')
                                                .doc(docID)
                                                .update({
                                              'favorite': true,
                                            });
                                            FirebaseFirestore.instance
                                                .collection('favorite')
                                                .doc()
                                                .set({
                                              'item': snapshot.data!.docs[index]
                                                  ['item'],
                                              'price': snapshot
                                                  .data!.docs[index]['price'],
                                              'uid': snapshot.data!.docs[index]
                                                  ['uid'],   
                                            });

                                            AppToast.successToast(
                                                masg: "item Add in Favorite");
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: snapshot.data!.docs[index]
                                                        ['favorite'] ==
                                                    true
                                                ? Colors.green
                                                : Colors.grey,
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
