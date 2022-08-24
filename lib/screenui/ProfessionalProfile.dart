import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfessionalProfile extends StatefulWidget {
  final DocumentSnapshot snapshot;
  // final String contact_number;
  const ProfessionalProfile({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  _ProfessionalProfile createState() => _ProfessionalProfile();
}

class _ProfessionalProfile extends State<ProfessionalProfile> {
  TextEditingController _useerContactNumber = TextEditingController();
  TextEditingController _useerName = TextEditingController();
  List<String> cities = [
    'New Baneshowr',
    'Koteshwor',
    "Tinkune",
    "Sinamangal",
    'Old Baneshwor'
  ];
  Map<String, dynamic>? _profiledata;
  String? _contact_number;
  var _appoinmentDate;
  var _serviceLocation;
  @override
  void initState() {
    super.initState();
    _profiledata = widget.snapshot.data()! as Map<String, dynamic>;
    // print(_profiledata);
    _contact_number = widget.snapshot.id;
    // print(_contact_number);
  }

  Future<String> _getProfileImage() async {
    String _imageurl = await FirebaseStorage.instance
        .ref("${_contact_number}/profile")
        .getDownloadURL();
    // ProfileImage(_imageurl);
    return _imageurl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0), color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: _getProfileImage(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            snapshot.data.toString(),
                            width: 140,
                          ));
                    }),
                SizedBox(height: 25),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: Colors.deepOrangeAccent,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _profiledata!['Service Type'],
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Colors.blueAccent),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_city_rounded,
                      color: Colors.deepOrangeAccent,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _profiledata!['Location'],
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Colors.blueAccent),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.price_change_sharp,
                      color: Colors.deepOrangeAccent,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      _profiledata!['Price'],
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Colors.blueAccent),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.date_range_rounded,
                      color: Colors.deepOrangeAccent,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${_profiledata!['Experience']} years",
                      // _profiledata!['Experience'],

                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          color: Colors.blueAccent),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 60,
                  width: 250,
                  // padding: EdgeInsets.only(left:35),
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Center(
                    child: TextButton(
                        onPressed: () {
                          _bookAppoinment();
                          // print("New Profile");
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => GeneralInfoTab()));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: AssetImage(
                                    "assets/booking.png",
                                  )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Book Appoinment',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _bookAppoinment() async {
    _useerContactNumber.text = _contact_number.toString();
    _useerName.text = _profiledata!['User Name'];
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _useerName,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                    hint: Text(
                      "Location",
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
                        _serviceLocation = newValue.toString();
                        // print(_serviceLocation);
                      });
                    }),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _useerContactNumber,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 15)),
                        ).then(
                          (value) => _appoinmentDate = (value.toString()),
                        );
                      },
                      child: const Text("Appoinment Date",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800))),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text('BOOK'),
                  onPressed: () async {},
                )
              ],
            ),
          );
        });
  }
}
