import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:homeprofessional/models/service.dart';
import 'package:homeprofessional/screenui/ViewProfessionalInfo.dart';
import 'package:homeprofessional/screenui/DocumentationTab.dart';
import 'package:homeprofessional/screenui/Cleaner.dart';
import 'package:homeprofessional/screenui/loginpage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:homeprofessional/screenui/GeneralInfoTab.dart';
import 'package:homeprofessional/screenui/ProfessionalDataTab.dart';

import "package:firebase_core/firebase_core.dart";

class HomePage extends StatefulWidget {
  final haveaccount;
  final String contact_number;

  const HomePage(
      {Key? key, required this.haveaccount, required this.contact_number})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _imageurl;
  bool? _professionalProfileExist;

  final _databaseRef = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("Professional Information")
        .doc(widget.contact_number)
        .get()
        .then((value) {
      if (value.exists) {
        _professionalProfileExist = value.exists;
        // return _professionalProfileExist;
      } else {
        _professionalProfileExist = value.exists;
      }
    }).onError((error, stackTrace) {
      _professionalProfileExist = false;
    });
  }

  List<Service> services = [
    Service('Cleaner',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Plumber',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Electrician',
        'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Painter',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
    Service('Gardener',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
  ];

  List<dynamic> workers = [
    [
      'XYZ',
      'Plumber',
      'https://images.unsplash.com/photo-1506803682981-6e718a9dd3ee?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=c3a31eeb7efb4d533647e3cad1de9257',
      4.8
    ],
    [
      'QWERTY',
      'Cleaner',
      'https://thumbs.dreamstime.com/z/female-construction-worker-cartoon-character-colorful-73190552.jpg',
      4.6
    ],
    [
      'Ram Setu',
      'Driver',
      'https://cdn4.iconfinder.com/data/icons/characters-4/512/1-09-512.png',
      4.4
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        actions: [

        
        
         Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical:1,horizontal: 5),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  },
                  icon: Icon(
                    Icons.logout_sharp,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.teal),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      padding:
                          EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Row(
                        children: [
                          if (widget.haveaccount) ...[
                            FutureBuilder(
                                future: _getProfileImage(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        snapshot.data.toString(),
                                        width: 100,
                                      ));
                                }),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StreamBuilder(
                                    stream: _databaseRef
                                        .collection("Personal Information")
                                        .doc(widget.contact_number)
                                        .snapshots(),
                                    builder: ((context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasError) {
                                        return const Text(
                                            "Something went Wrong");
                                      }
                                      if (streamSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading");
                                      }
                                      if (streamSnapshot.hasData) {
                                        return Text(
                                            streamSnapshot.data!
                                                .get(FieldPath.fromString(
                                                    "User Name"))
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold));
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    })),
                                SizedBox(
                                  height: 5,
                                ),
                                if (_professionalProfileExist == true) ...[
                                  StreamBuilder(
                                      stream: _databaseRef
                                          .collection(
                                              "Professional Information")
                                          .doc(widget.contact_number)
                                          .snapshots(),
                                      builder: ((context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              streamSnapshot) {
                                        if (streamSnapshot.hasError) {
                                          return const Text(
                                              "Something went Wrong");
                                        }
                                        if (streamSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text("Loading");
                                        }
                                        if (streamSnapshot.hasData) {
                                          // print(streamSnapshot.data!
                                          //     .get(FieldPath.fromString(
                                          //         ""))
                                          //     .toString());
                                          return Text(
                                              streamSnapshot.data!
                                                  .get(FieldPath.fromString(
                                                      "Service Type"))
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold));
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      })),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Center(
                                      child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewProfessionalInfo(
                                                    haveaccount:
                                                        _professionalProfileExist!,
                                                    contact_number:
                                                        widget.contact_number,
                                                  )));
                                    },
                                    child: Text(
                                      'View Profile',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ] else ...[
                            // Padding(padding: EdgeInsets.only(left:0,right:0),child:
                            Container(
                              height: 60,
                              width: 250,
                              // padding: EdgeInsets.only(left:35),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                child: TextButton(
                                    onPressed: () {
                                      // print("New Profile");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GeneralInfoTab()));
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                            "assets/useraccount.png",
                                          )),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'CREATE PROFILE',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            // ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(0, 4),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View all',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        height: 300,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: services.length,
                            itemBuilder: (BuildContext context, int index) {
                              return serviceContainer(services[index].imageURL,
                                  services[index].name, index);
                            }),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Rated',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View all',
                                ))
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: workers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return workerContainer(
                                  workers[index][0],
                                  workers[index][1],
                                  workers[index][2],
                                  workers[index][3]);
                            }),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _getProfileImage() async {
    String _imageurl = await FirebaseStorage.instance
        .ref("${widget.contact_number}/profile")
        .getDownloadURL();
    // ProfileImage(_imageurl);
    return _imageurl;
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, name.toString());
          },
          child: Container(
            margin: EdgeInsets.only(right: 3),
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(
                color: Colors.blue.withOpacity(0),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(image, height: 30),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 12),
                  )
                ]),
          )),
    );
  }

  workerContainer(String name, String job, String image, double rating) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(image)),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      job,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 20,
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
