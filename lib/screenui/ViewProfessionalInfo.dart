import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewProfessionalInfo extends StatefulWidget {
  const ViewProfessionalInfo({Key? key}) : super(key: key);

  @override
  _ViewProfessionalInfoState createState() => _ViewProfessionalInfoState();
}

class _ViewProfessionalInfoState extends State<ViewProfessionalInfo> {
  final _databaseRef = FirebaseFirestore.instance;
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
                      "DOCUMENTS",
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
                    .doc("9810438054")
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot);
                    return const Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (snapshot.hasData) {
                    print(snapshot.data!);
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!;

                          Map<String, dynamic> data =
                              documentSnapshot.data()! as Map<String, dynamic>;
                          // print('document,${documentSnapshot.get(Key).toString()}');
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade300),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Container(
                                    width: 400,
                                    padding: EdgeInsets.all(5.0),
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
                                              MainAxisAlignment.spaceAround,
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
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {},
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 400,
                                    padding: EdgeInsets.all(5.0),
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
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(data['Contact Number'],
                                                style: TextStyle(
                                                    color: Colors.cyan,
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(),
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {},
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 400,
                                    padding: EdgeInsets.all(5.0),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data['Gender'],
                                                style: TextStyle(
                                                    color: Colors.cyan,
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {},
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 400,
                                    padding: EdgeInsets.all(5.0),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data['Date of Birth'],
                                                style: TextStyle(
                                                    color: Colors.cyan,
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {},
                                            )
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
              child: StreamBuilder(
                stream: _databaseRef
                    .collection("Professional Information")
                    .doc("9810438054")
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot);
                    return const Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (snapshot.hasData) {
                    print(snapshot.data!);
                    return ListView.builder(
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!;

                          Map<String, dynamic> data =
                              documentSnapshot.data()! as Map<String, dynamic>;
                          // print('document,${documentSnapshot.get(Key).toString()}');
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade300),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 400,
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                           mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '${data['Service Type']}',
                                              style: TextStyle(
                                                  color: Colors.cyan,
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {},
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {},
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      width: 400,
                                      padding: EdgeInsets.all(5.0),
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
                                              MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(data['Location'],
                                                  style: TextStyle(
                                                      color: Colors.cyan,
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      width: 400,
                                      padding: EdgeInsets.all(.0),
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
                                              MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(data['Experience'],
                                                  style: TextStyle(
                                                      color: Colors.cyan,
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      width: 400,
                                      padding: EdgeInsets.all(5.0),
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
                                              MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(data['Price'],
                                                  style: TextStyle(
                                                      color: Colors.cyan,
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
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
            Container(),
          ]),
        ));
  }
}
