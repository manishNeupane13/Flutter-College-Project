import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String name;
  final String imageURL;

  Service(this.name, this.imageURL);
}

class ProfessionalID {
  final String id;
  ProfessionalID(this.id);
  
}

class Professional {
  final String location;
  final String price;
  final String serviceType;
  Professional(this.location, this.price, this.serviceType);

  Map<String, dynamic> toMap() {
    return {'location': location, 'price': price, 'serviceType': serviceType};
  }

  Professional.fromMap(
    Map<String, dynamic> professionalMap,
  )   : location = professionalMap['location'],
        price = professionalMap['price'],
        serviceType = professionalMap['serviceType'];

  Professional.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : location = doc.data()!["Location"],
        price = doc.data()!["Price"],
        serviceType = doc.data()!["Service Type"];
}

class GeneralInfo {
  final String name;
  final String contact_number;
  final String gender;
  // final Professional professional_info;

  GeneralInfo(
    this.name,
    this.contact_number,
    this.gender,
    // this.professional_info
  );
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact_number': contact_number,
      'gender': gender,
      // "Professional Info": professional_info
    };
  }

  GeneralInfo.fromMap(
    Map<String, dynamic> GeneralMap,
  )   : name = GeneralMap["User Name"],
        contact_number = GeneralMap["Contact Number"],
        gender = GeneralMap["Gender"];
  GeneralInfo.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : name = doc.data()!["User Name"],
        contact_number = doc.data()!["Contact Number"],
        gender = doc.data()!["Gender"];
  // professional_info = Professional.fromMap(doc.data()!["address"]);

}
