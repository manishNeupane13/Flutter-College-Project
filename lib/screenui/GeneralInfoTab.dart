import 'package:flutter/material.dart';
import 'package:homeprofessional/models/gender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeprofessional/screenui/ProfessionalDataTab.dart';
import 'package:homeprofessional/screenui/DocumentationTab.dart';

class GeneralInfoTab extends StatefulWidget {
  const GeneralInfoTab({Key? key}) : super(key: key);

  @override
  _GeneralInfoTabState createState() => _GeneralInfoTabState();
}

class _GeneralInfoTabState extends State<GeneralInfoTab> {
  final _userName = TextEditingController();
  final _userNumber = TextEditingController();
  var _dateOfBirth;
  var gender;
  var _zoneName;
  var _districtName;
  var _cityName;
  var _provinceName;

  List<Gender> genders = [
    Gender("Male", Icons.male_rounded, false),
    Gender("Female", Icons.female_rounded, false),
    Gender("Others", Icons.transgender_rounded, false)
  ];

  List<String> cities = [
    'New Baneshowr',
    'Koteshwor',
    "Tinkune",
    "Sinamangal",
    'Old Baneshwor'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(color: Color.fromARGB(255, 231, 226, 211)),
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
                        "General Information",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
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
                          hintText: "User Name",
                        ),
                        keyboardType: TextInputType.text,
                        controller: _userName,
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
                          hintText: "Contact Number",
                        ),
                        keyboardType: TextInputType.number,
                        controller: _userNumber,
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue,
                        ),
                        child: TextButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now())
                                  .then(
                                (value) => _dateOfBirth = (value.toString()),
                              );
                            },
                            child: const Text("Date of Birth",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: genders.length,
                                  itemBuilder:
                                      ((BuildContext context, int index) {
                                    return InkWell(
                                      splashColor: Colors.pinkAccent,
                                      onTap: () {
                                        setState(() {
                                          genders.forEach((gender) =>
                                              gender.isSelected = false);
                                          genders[index].isSelected = true;
                                          gender =
                                              genders[index].name.toString();
                                          print(gender);
                                        });
                                      },
                                      child: GenderRadio(
                                          genders[index].name,
                                          genders[index].icon,
                                          genders[index].isSelected),
                                    );
                                  }))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
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
                        "Address Information",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      DropdownButtonFormField(
                          hint: Text(
                            "Province Name",
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
                              _provinceName = newValue.toString();
                              print(_provinceName);
                            });
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                          hint: Text(
                            "Zone",
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
                              _zoneName = newValue.toString();
                              print(_zoneName);
                            });
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                          hint: Text(
                            "District",
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
                              _districtName = newValue.toString();
                              print(_districtName);
                            });
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                          hint: Text(
                            "City",
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
                              _cityName = newValue.toString();
                              print(_cityName);
                            });
                          }),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: 150,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.grey.shade700, width: 2.0)),
                    child: TextButton(
                        onPressed: () {
                          storeGeneralInfo();
                          _askProfressionalProfilePermission();
                        },
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
        ));
  }

  GenderRadio(String name, IconData genderIcon, bool isSelected) {
    return Container(
      // color: Color(0xFF3B4257),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Color.fromARGB(255, 41, 39, 39),
          width: 2.0,
        ),
      ),
      height: 80,
      width: 80,
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            genderIcon,
            color: isSelected ? Colors.tealAccent : Colors.grey,
            size: 30,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
                color: isSelected
                    ? Colors.tealAccent
                    : Color.fromARGB(255, 29, 28, 28)),
          )
        ],
      ),
    );
  }

  storeGeneralInfo() {
    final user_name = _userName.text.trim();
    final number = _userNumber.text.trim();
    final dob = _dateOfBirth.toString();
    final gender_val = gender.toString();
    final province_name = _provinceName.toString();
    final district_name = _districtName.toString();
    final zone_name = _zoneName.toString();
    final city_name = _cityName.toString();
    // print(number);
// storing personal details
    if (user_name.isNotEmpty &&
        number.isNotEmpty &&
        dob.isNotEmpty &&
        gender_val.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("Personal Information")
          .doc(number)
          .set({
        "User Name": user_name,
        "Contact Number": number,
        "Date of Birth": dob,
        "Gender": gender_val
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Information Storage Sucessfull.",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: "Information Storage UnSucessfull.",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      });
      // storing address
    } else {
      Fluttertoast.showToast(
          msg: "Enter Necessary Information",
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
    }
    if (number.isNotEmpty &&
        province_name.isNotEmpty &&
        district_name.isNotEmpty &&
        zone_name.isNotEmpty &&
        city_name.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("Address Information")
          .doc(number)
          .set({
        "Province": province_name,
        "Zone": zone_name,
        "District": district_name,
        "City": city_name
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Information Storage Sucessfull.",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: "Information Storage UnSucessfull.",
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            fontSize: 12);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Enter Necessary Information",
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
    }
  }

  Future<void> _askProfressionalProfilePermission() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Do you want to create Professional Profile?",
              style: TextStyle(
                  color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ListBody(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessionalDataTab(
                                    contact_number:
                                        _userNumber.text.trim().toString())));
                      },
                      child: const Text("YES"),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentationTab(
                                    contact_number:
                                        _userNumber.text.trim().toString())));
                      },
                      child: const Text("No"),
                    )
                  ],
                )
              ]),
            ),
          );
        });
  }
}
