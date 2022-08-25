import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homeprofessional/screenui/ProfessionalProfile.dart';

class Plumber extends StatefulWidget {
  const Plumber({Key? key}) : super(key: key);

  @override
  _PlumberState createState() => _PlumberState();
}

class _PlumberState extends State<Plumber> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PLUMBER',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: Container(
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
                        .collection("Plumber")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.data == null) {
                        return const Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      } else if (streamSnapshot.hasData) {
                        return ListView.builder(
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];

                              // print(documentSnapshot.id);

                              Map<String, dynamic> data = documentSnapshot
                                  .data()! as Map<String, dynamic>;
                              // print(data['User Name']);
                              // print(idlist?[index]);
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
                                        // _moreDetails(documentSnapshot);
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
                      } else if (streamSnapshot.hasError) {
                        return const Text("Something went Wrong");
                      } else if (streamSnapshot.connectionState ==
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
    );
  }
}
