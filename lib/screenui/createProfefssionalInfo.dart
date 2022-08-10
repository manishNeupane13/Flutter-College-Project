import 'package:flutter/material.dart';
import 'package:homeprofessional/models/service.dart';
import 'package:homeprofessional/screenui/ProfessionalDataTab.dart';
import 'package:homeprofessional/screenui/GeneralInfoTab.dart';
import 'package:homeprofessional/screenui/DocumentationTab.dart';

class CreateProfefssionalInfo extends StatefulWidget {
  const CreateProfefssionalInfo({Key? key}) : super(key: key);

  @override
  _CreateProfefssionalInfoState createState() =>
      _CreateProfefssionalInfoState();
}

class _CreateProfefssionalInfoState extends State<CreateProfefssionalInfo> {
  // DateTime _dateofbirth;
  // late TabController _tabController;
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
            GeneralInfoTab(),
            ProfessionalDataTab(contact_number: 9810438054),
            DocumentationTab(contact_number: 9810438054)
          ]),
        ));
  }
}
