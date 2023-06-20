import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamic_guide/Models/MosqueModel.dart';


class MosqueKeeperModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? registeredOn;
  String? profileImageUrl;
  String? contactNo;
  MosqueModel? addedMosque;
  String? userType;
  String? address;
  String? token;

  MosqueKeeperModel(
      {this.name,
        this.email,
        this.registeredOn,
        this.profileImageUrl,
        this.contactNo,
        this.addedMosque,
        this.uid,
        this.address,
        this.token,
        this.userType
      });

  MosqueKeeperModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['image'];
    contactNo = json['phoneNumber'];
    userType = json['userType'];
    uid = json['uid'];
    address =json['address'];
    token = json['token'];
    addedMosque = MosqueModel.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['registeredOn'] = this.registeredOn;
    data['image'] = this.profileImageUrl;
    data['phoneNumber'] = this.contactNo;
    data['addedMosque'] = this.addedMosque?.toJson();
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['address'] = this.address;
    data['userType'] = this.userType;
    return data;
  }
}
