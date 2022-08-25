import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeprofessional/models/service.dart';
import 'package:homeprofessional/screenui/homePage.dart';

class ViewProfessionalInfo extends StatefulWidget {
  final bool haveaccount;
  final String contact_number;
  const ViewProfessionalInfo(
      {Key? key, required this.haveaccount, required this.contact_number})
      : super(key: key);

  @override
  _ViewProfessionalInfoState createState() => _ViewProfessionalInfoState();
}

class _ViewProfessionalInfoState extends State<ViewProfessionalInfo> {
  final _servicePrice = TextEditingController();
  final _experienceYear = TextEditingController();

  List<String> cities = [
    'New Baneshowr',
    'Koteshwor',
    "Tinkune",
    "Sinamangal",
    'Old Baneshwor'
  ];

  List<String> profession_name = [
    'Cleaner',
    'Plumber',
    "Electrician",
    "Painter",
    'Carpenter',
    "Gardener",
  ];
  final _databaseRef = FirebaseFirestore.instance;
  final TextEditingController _priceController = TextEditingController();
  var _locationController;

  var _serviceProvided;

  var _serviceLocation;
  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("Professional Information")
    //     .doc(widget.contact_number)
    //     .get()
    //     .then((value) {
    //   value.exists ? widget.haveaccount = true : widget.haveaccount = false;

    //   print(widget.haveaccount);
    // }).onError((error, stackTrace) {
    //   widget.haveaccount == false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 215, 237, 185),
            bottom: TabBar(
                // controller: _tabController,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.deepOrange),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 6,
                indicatorPadding: EdgeInsets.all(3.0),
                unselectedLabelColor: Colors.grey.shade600,
                tabs: [
                  Tab(
                    // text: "Personal",
                    child: Text(
                      "PERSONAL",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.info_rounded,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "PROFESSIONAL",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    icon: Icon(Icons.work_outline),
                  ),
                  Tab(
                    child: Text(
                      "APPOINMENTS",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    icon: Icon(Icons.document_scanner),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white54),
              child: StreamBuilder(
                stream: _databaseRef
                    .collection("Personal Information")
                    .doc(widget.contact_number)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    // print(snapshot);
                    return const Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (snapshot.hasData) {
                    // print(snapshot.data!);
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!;

                          Map<String, dynamic> data =
                              documentSnapshot.data()! as Map<String, dynamic>;
                          // print('document,${documentSnapshot.get(Key).toString()}');
                          return Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade300),
                            child: Column(
                              children: [
                                Container(
                                  width: 250,
                                  padding: EdgeInsets.all(3.0),
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 22,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data['User Name']}',
                                            style: TextStyle(
                                                color: Colors.cyan,
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 250,
                                  padding: EdgeInsets.all(3.0),
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Contact Number',
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 22,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(data['Contact Number'],
                                              style: TextStyle(
                                                  color: Colors.cyan,
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 250,
                                  padding: EdgeInsets.all(3.0),
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Gender',
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 22,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(data['Gender'],
                                              style: TextStyle(
                                                  color: Colors.cyan,
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 250,
                                  padding: EdgeInsets.all(3.0),
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date of Birth',
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 22,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(data['Date of Birth'],
                                              style: TextStyle(
                                                  color: Colors.cyan,
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          );
                        }));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white54),
                child: (widget.haveaccount == true)
                    ? StreamBuilder(
                        stream: _databaseRef
                            .collection("Professional Information")
                            .doc(widget.contact_number)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            // print(snapshot);
                            return const Text("Something went wrong");
                          }
                          if (!snapshot.data!.exists) {
                            return Center(
                                child: Text(
                              "No Data Found",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.redAccent),
                            ));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }
                          if (snapshot.hasData) {
                            // print(snapshot.data!);
                            return ListView.builder(
                                itemCount: 1,
                                itemBuilder: ((context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      snapshot.data!;
                                  Map<String, dynamic> data = documentSnapshot
                                      .data()! as Map<String, dynamic>;

                                  // print('document,${documentSnapshot.get(Key).toString()}');
                                  return Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.shade300),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 250,
                                            padding: EdgeInsets.all(2.0),
                                            margin: EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Service Type',
                                                  style: TextStyle(
                                                      color: Colors.deepOrange,
                                                      fontSize: 22,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      '${data['Service Type']}',
                                                      style: TextStyle(
                                                          color: Colors.cyan,
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                              width: 250,
                                              padding: EdgeInsets.all(2.0),
                                              margin: EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Location',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepOrange,
                                                        fontSize: 22,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(data['Location'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.cyan,
                                                              fontSize: 18,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          onPressed: () =>
                                                              _updateLocation(
                                                                  documentSnapshot))
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                              width: 250,
                                              padding: EdgeInsets.all(2.0),
                                              margin: EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Experience',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepOrange,
                                                        fontSize: 22,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          '${data['Experience']} years',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.cyan,
                                                              fontSize: 18,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.edit),
                                                        onPressed: () {},
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                              width: 250,
                                              padding: EdgeInsets.all(2.0),
                                              margin: EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Price',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepOrange,
                                                        fontSize: 22,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(data['Price'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.cyan,
                                                              fontSize: 18,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          onPressed: () =>
                                                              _updatePrice(
                                                                  documentSnapshot)),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 50),
                                              child: Container(
                                                height: 50,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                child: Center(
                                                    child: TextButton(
                                                  onPressed: () {
                                                    _deleteProfessionaAccount(
                                                        documentSnapshot);
                                                    // _createProfessionaAccount(
                                                    //     widget.contact_number);
                                                  },
                                                  child: Text(
                                                    'Delete Professional Profile',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                )),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                          } else {
                            return Center(
                                child: Text(
                              "No data Found",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.redAccent),
                            ));
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    : _createProfessionaAccount(widget.contact_number)
                // Text("No Data Found")
                ),
            Container(),
          ]),
        ));
  }

  Future<void> _updateLocation(DocumentSnapshot? documentSnapshot) async {
    Map<String, dynamic> data =
        documentSnapshot?.data()! as Map<String, dynamic>;
    // if (data != null) {
    //   _locationController.text = data['Location'];
    // }
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                    hint: Text(
                      "Service Location",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    items: cities
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _locationController = newValue.toString();
                        // print(_serviceLocation);
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    if (_locationController != null) {
                      await _databaseRef
                          .collection("Professional Information")
                          .doc(documentSnapshot!.id)
                          .update({"Location": _locationController.toString()});

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  _updatePrice(DocumentSnapshot? documentSnapshot) async {
    Map<String, dynamic> data =
        documentSnapshot?.data()! as Map<String, dynamic>;
    if (data != null) {
      _priceController.text = data['Price'];
    }
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    if (_priceController.text.trim() != null) {
                      await _databaseRef
                          .collection("Professional Information")
                          .doc(documentSnapshot!.id)
                          .update({
                        "Price": _priceController.text.trim().toString()
                      });

                      _priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _deleteProfessionaAccount(
      DocumentSnapshot? documentSnapshot) async {
    Map<String, dynamic> data =
        documentSnapshot?.data()! as Map<String, dynamic>;

    await _databaseRef
        .collection("Professional Information")
        .doc(documentSnapshot!.id)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection(data['Service Type'])
          .doc(documentSnapshot.id)
          .delete();

      Fluttertoast.showToast(
          msg: "Professional profile deletion sucessfull",
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                  haveaccount: true, contact_number: widget.contact_number)));
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "Professional profile deletion unsucessfull",
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
    });
  }

  _createProfessionaAccount(String contact_number) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(color: Color.fromARGB(255, 215, 169, 195)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
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
                    "Work Information",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  DropdownButtonFormField(
                      hint: Text(
                        "Profession Name",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      items: profession_name
                          .map((value) => DropdownMenuItem(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _serviceProvided = newValue.toString();
                          // print(_serviceProvided);
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField(
                      hint: Text(
                        "Service Location",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      items: cities
                          .map((value) => DropdownMenuItem(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _serviceLocation = newValue.toString();
                          // print(_serviceLocation);
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the value';
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Year of Experience",
                    ),
                    keyboardType: TextInputType.number,
                    controller: _experienceYear,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the value';
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Price ",
                    ),
                    keyboardType: TextInputType.number,
                    controller: _servicePrice,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                width: 150,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15.0),
                    border:
                        Border.all(color: Colors.grey.shade700, width: 2.0)),
                child: TextButton(
                    onPressed: storeProfessionalInfo,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.storage_sharp,
                          color: Colors.white,
                        ),
                        Text(
                          " SAVE ",
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
    );
  }

  // bool? get checkProfileexist {
  //   bool? professionalProfileExist;
  //   FirebaseFirestore.instance
  //       .collection("Professional Information")
  //       .doc(widget.contact_number)
  //       .get()
  //       .then((value) {
  //     value.exists
  //         ? professionalProfileExist = true
  //         : professionalProfileExist = false;

  //     print(professionalProfileExist);
  //   });
  //   return professionalProfileExist;
  // }

  void storeProfessionalInfo() {
    final location_name = _serviceLocation.toString();
    final experience_year = _experienceYear.text.trim();
    final service_price = _servicePrice.text.trim();
    final service_provided = _serviceProvided.toString();
    // print('$location_name,$experience_year,$service_provided,$service_price');
    if (location_name.isNotEmpty &&
        experience_year.isNotEmpty &&
        service_price.isNotEmpty &&
        service_provided.isNotEmpty) {
      // print(widget.contact_number);
      FirebaseFirestore.instance
          .collection("Personal Information")
          .doc(widget.contact_number)
          .get()
          .then((value) {
        var data = value.data();
        // print(data);

        FirebaseFirestore.instance
            .collection(service_provided)
            .doc(widget.contact_number)
            .set({
              "User Name": data!['User Name'],
              "Contact Number": data["Contact Number"],
              "Gender": data["Gender"],
              'Service Type': service_provided,
              "Location": location_name,
              "Price": service_price,
              "Experience": experience_year,
            })
            .then((value) {})
            .onError((error, stackTrace) {
              print(error);
            });
      });
      FirebaseFirestore.instance
          .collection("Professional Information")
          .doc(widget.contact_number)
          .set({
        'Service Type': service_provided,
        "Location": location_name,
        "Price": service_price,
        "Experience": experience_year
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Information Storage Sucessfull.",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                    haveaccount: true, contact_number: widget.contact_number)));
      }).onError((error, stackTrace) {
        print(error);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Enter all Information.",
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
    }
  }
}
