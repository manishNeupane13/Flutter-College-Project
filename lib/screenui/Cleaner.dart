import 'package:homeprofessional/screenui/ProfessionalProfile.dart';
import 'package:flutter/material.dart';
import 'package:homeprofessional/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cleaner extends StatefulWidget {
  const Cleaner({Key? key}) : super(key: key);

  @override
  _CleanerState createState() => _CleanerState();
}

class _CleanerState extends State<Cleaner> {
  Future<List<GeneralInfo>>? generalinfolist;
  List<GeneralInfo>? retrivedGeneralInfoList;

  @override
  void initState() {
    super.initState();
    // print("init inside");
    // _retivalfun();
  }

  // Future<void> _retivalfun() async {
  //   generalinfolist = getGeneralInfo();
  //   retrivedGeneralInfoList = await getGeneralInfo();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          // SingleChildScrollView(

          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.deepOrangeAccent),
              child:
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  Padding(
                      padding: EdgeInsets.all(3.0),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Cleaner")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                                itemCount: streamSnapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  // var myList = streamSnapshot.data!.docs[index]
                                  //     as List<DocumentSnapshot>;
                                  // print(myList);

                                  Map<String, dynamic> data = documentSnapshot
                                      .data()! as Map<String, dynamic>;
                                  // print(data['User Name']);
                                  return SingleChildScrollView(
                                      padding: EdgeInsets.all(5.0),
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfessionalProfile(
                                                          snapshot:
                                                              documentSnapshot,
                                                        )));
                                          },
                                          trailing: SizedBox(
                                            width: 100,
                                            child: Row(children: [
                                              (data['Gender'] == "Male")
                                                  ? (Icon(
                                                      Icons.male_outlined,
                                                      color: Colors.black,
                                                      size: 60.0,
                                                    ))
                                                  : (Icon(
                                                      Icons.female_outlined,
                                                      color: Colors.black,
                                                      size: 60.0,
                                                    ))
                                            ]),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          title: Text(
                                            data['User Name'],
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            data['Contact Number'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ));
                                });
                          }
                          if (streamSnapshot.hasError) {
                            return const Text("Something went Wrong");
                          }
                          if (streamSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading");
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                      // child: FutureBuilder(
                      //     future: generalinfolist,
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<List<GeneralInfo>> snapshot) {
                      //       if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      //         ListView.builder(
                      //             itemCount: retrivedGeneralInfoList!.length,
                      //             itemBuilder: (context, index) {
                      //               print(retrivedGeneralInfoList![index].name);
                      //               return Container(
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.amberAccent,
                      //                     borderRadius: BorderRadius.circular(16.0)),
                      //                 child: ListTile(
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.circular(8.0)),
                      //                   title: Text(
                      //                       retrivedGeneralInfoList![index].name),
                      //                 ),
                      //               );
                      //             });
                      //       }
                      //       return Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     }),
                      )
              // ],
              //),
              ),
      // ),
    );
  }
}

Future<List<GeneralInfo>> getGeneralInfo() async {
  QuerySnapshot<Map<String, dynamic>> GeneralInfoSnapshot =
      await FirebaseFirestore.instance.collection("Personal Information").get();
  return (GeneralInfoSnapshot.docs
      .map((docsnapshot) => GeneralInfo.fromDocumentSnapshot(docsnapshot))
      .toList());
}

Future<List<Professional>> getProfessionalInfo() async {
  QuerySnapshot<Map<String, dynamic>> ProfessionalInfoSnapshot =
      await FirebaseFirestore.instance
          .collection("Professional Information")
          .get();
  return (ProfessionalInfoSnapshot.docs
      .map((docsnapshot) => Professional.fromDocumentSnapshot(docsnapshot))
      .toList());
}
