import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamic_guide/models/MosqueModel.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  Timestamp? registeredOn;
  String? profileImageUrl;
  List<MosqueModel>? addedMosque;
  String? userType;
  String? token;

  UserModel(
      {this.name,
        this.email,
        this.registeredOn,
        this.profileImageUrl,
        this.addedMosque,
        this.uid,
        this.userType,
        this.token
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['profileImageUrl'];
    if (json['addedMosque'] != null) {
      addedMosque = List<MosqueModel>.from(json['addedMosque'].map((model) => MosqueModel.fromJson(model))).toList();
    }
    userType = json['userType'];
    uid = json['uid'];
    userType =json['userType'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['registeredOn'] = this.registeredOn;
    data['profileImageUrl'] = this.profileImageUrl;
    data['addedMosque'] = addedMosque?.map((mosque) => mosque.toJson()).toList();
    data['userType'] = this.userType;
    data['uid'] = this.uid;
    data['token'] = this.token;
    return data;
  }
}
