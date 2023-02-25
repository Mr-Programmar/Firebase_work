import 'package:firebase_work/Sir_Screens/fcm_Services-1.dart';
import 'package:firebase_work/app_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController item_name = TextEditingController();
  TextEditingController item_price = TextEditingController();
  TextEditingController item_catagory = TextEditingController();
  TextEditingController item_ID = TextEditingController();
  TextEditingController userid = TextEditingController();
  File? image;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              TextFormField(
                controller: item_name,
                decoration: InputDecoration(label: Text("Item name")),
              ),
              TextFormField(
                controller: item_price,
                decoration: InputDecoration(label: Text("Item price")),
              ),
              TextFormField(
                controller: item_catagory,
                decoration: InputDecoration(label: Text("item_catagory")),
              ),
              TextFormField(
                controller: item_ID,
                decoration: InputDecoration(label: Text("Item id")),
              ),
              TextFormField(
                controller: userid,
                decoration: InputDecoration(label: Text("user id")),
              ),
              InkWell(
                onTap: () {
                  FCMServices.displyNotification(title: "title", body: "body");

                  // pickerBottomSheet();
                },
                child: Container(
                  child: Text("Add image"),
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
              SizedBox(
                height: 40,
              ),

              ElevatedButton(
                  onPressed: () {

                    // try {
                    //   FirebaseFirestore.instance.collection("t1").doc().set({
                    //     'name': item_name.text,
                    //     "price": item_price.text,
                    //   }).then((value) {
                    //     print("added");
                    //   }).catchError((e) {
                    //     print(
                    //         "FIREBASE_CATCH___________________________________________________________ $e");
                    //   });
                    //   item_price.clear();
                    //   item_name.clear();
                    //   AppToast.successToast(masg: " data saved");
                    // } catch (e) {
                    //   AppToast.failToast(masg: "Not Saved");
                    //   print("try____________        $e");
                    // }
                    FCMServices.sendFCMNotification(to: '/topics/manager', title: "New Product", body: "New Man Product added");
                  },
                  child: Text("ADD ")),

            ],
          ),
        ),
      ),
    );
  }

  pickerBottomSheet() {
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
                    pickCameraImage();
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
                    pickGalleryImage();
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
  pickGalleryImage() async {
    print("Iamge Pick....");
    ImagePicker picker = ImagePicker();

    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    File? imagePath = File(pickedFile!.path);
    print("imagePath: $imagePath");
    setState(() {
      image = imagePath;
    });
    // cropImage(pickedFile);
  }
  pickCameraImage() async {
    print("Iamge Pick....");
    ImagePicker picker = ImagePicker();

    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    File? imagePath = File(pickedFile!.path);
    print("imagePath: $imagePath");
    setState(() {
      image = imagePath;
    });
  }


}
