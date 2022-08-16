import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:homeprofessional/screenui/homePage.dart';

class DocumentationTab extends StatefulWidget {
  final contact_number;
  const DocumentationTab({Key? key, required this.contact_number})
      : super(key: key);

  @override
  _DocumentationTabState createState() => _DocumentationTabState();
}

class _DocumentationTabState extends State<DocumentationTab> {
  UploadTask? uploadtofirebase;

  File? profile_image_file, identity_image_file;
  // var fileToUpload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(color: Color.fromARGB(255, 243, 180, 155)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  width: 450,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PROFILE PICTURE",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            pickFile("Profile");
                          },
                          child: Container(
                              width: 200,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.all(3.0),
                              decoration:
                                  BoxDecoration(color: Colors.lightGreenAccent),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.account_box,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Pick Picture",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 450,
                  height: 180,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "IDENTITY VERIFICATION",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            pickFile("Identity");
                          },
                          child: Container(
                              width: 200,
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.all(3.0),
                              decoration:
                                  BoxDecoration(color: Colors.lightGreenAccent),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.account_box,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Pick Picture",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                    width: 250,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.grey.shade700, width: 2.0)),
                    child: TextButton(
                        onPressed: upLoadToFirebase,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              "Upload Document",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ))),
              ],
            ),
          ),
        ));
  }

  Future<void> pickFile(fileheader) async {
    print(fileheader);
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      final file_path = result.files.single.path!;
      print(file_path);
      setState(() {
        if (fileheader == "Profile") {
          profile_image_file = File(file_path);
          print(profile_image_file);
        } else if (fileheader == "Identity") {
          identity_image_file = File(file_path);
          print(identity_image_file);
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Select Images",
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
    }
  }

  Future upLoadToFirebase() async {
    if (profile_image_file != null && identity_image_file != null) {
      final number = widget.contact_number;
      final profile_destination = '$number/profile';
      final identity_destination = '$number/identity';
      try {
        FirebaseStorage.instance
            .ref(profile_destination)
            .putFile(profile_image_file!)
            .then((p0) {
          Fluttertoast.showToast(
              msg: "Picture Uploading Sucessfull.",
              backgroundColor: Colors.teal,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              fontSize: 12);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(haveaccount:true,contact_number:widget.contact_number)));
        });
        FirebaseStorage.instance
            .ref(identity_destination)
            .putFile(identity_image_file!)
            .then((p0) {
          Fluttertoast.showToast(
              msg: "Picture Uploading Sucessfull.",
              backgroundColor: Colors.teal,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              fontSize: 12);
        });
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Picture Uploading UnSucessfull.",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      }
    }
  }
}
