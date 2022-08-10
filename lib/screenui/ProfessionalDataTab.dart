import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeprofessional/screenui/DocumentationTab.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfessionalDataTab extends StatefulWidget {
  final contact_number;

  const ProfessionalDataTab({Key? key, required this.contact_number})
      : super(key: key);

  @override
  _ProfessionalDataTabState createState() => _ProfessionalDataTabState();
}

class _ProfessionalDataTabState extends State<ProfessionalDataTab> {
  final _servicePrice = TextEditingController();
  final _experienceYear = TextEditingController();
  var _serviceProvided;

  var _serviceLocation;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
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
                        border: Border.all(
                            color: Colors.grey.shade700, width: 2.0)),
                    child: TextButton(
                        onPressed: (() {
                          final location_name = _serviceLocation.toString();
                          final experience_year = _experienceYear.text.trim();
                          final service_price = _servicePrice.text.trim();
                          final service_provided = _serviceProvided.toString();
                          print(
                              '$location_name,$experience_year,$service_provided,$service_price');
                          if (location_name.isNotEmpty &&
                              experience_year.isNotEmpty &&
                              service_price.isNotEmpty &&
                              service_provided.isNotEmpty) {
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
                                      builder: (context) => DocumentationTab(
                                          contact_number:
                                              widget.contact_number)));
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
                        }),
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
}
