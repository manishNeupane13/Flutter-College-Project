import 'package:flutter/cupertino.dart';

class Gender {
  String name;
  IconData icon;
  bool isSelected;
  Gender(this.name, this.icon, this.isSelected);
}

class ProfileImage {
  String imageurl;
  ProfileImage(this.imageurl);
}
