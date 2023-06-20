import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? registeredOn;
  String? profileImageUrl;
  String? contactNo;
  String? address;
  String? userType;
  String? token;

  AdminModel(
      {this.name,
        this.email,
        this.registeredOn,
        this.profileImageUrl,
        this.contactNo,
        this.uid,
        this.address,
        this.userType,
        this.token
      });

  AdminModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['profileImageUrl'];
    contactNo = json['contactNo'];
    uid = json['uid'];
    address =json['address'];
    token = json['token'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['registeredOn'] = this.registeredOn;
    data['profileImageUrl'] = this.profileImageUrl;
    data['contactNo'] = this.contactNo;
    data['userType'] = this.userType;
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['address'] = this.address;
    return data;
  }
}
