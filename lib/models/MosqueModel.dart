import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamic_guide/models/mosqueKeeperModel.dart';
import 'package:islamic_guide/models/prayerTimingModel.dart';
import 'package:islamic_guide/models/userModel.dart';
class MosqueModel {
  String? uid;
  String? name;
  double? latitude;
  double? longitude;
  Timestamp? registeredOn;
  String? profileImageUrl;
  String? mosqueKeeperUid;
  String? mosqueKeeperName;
  String? mosqueKeeperEmail;
  bool? isJamai;
  bool? isMadrasa;
  bool? isVerified;
  List<UserModel>? mosqueWitness;
  PrayerTimingModel? prayerTiming;
  String? address;
  String? token;

  MosqueModel(
      {this.name,
        this.registeredOn,
        this.profileImageUrl,
        this.uid,
        this.mosqueKeeperUid,
        this.mosqueKeeperName,
        this.mosqueKeeperEmail,
        this.isJamai,
        this.isMadrasa,
        this.address,
        this.latitude,
        this.isVerified,
        this.mosqueWitness,
        this.prayerTiming,
        this.longitude,
        this.token
      });

  MosqueModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    registeredOn = json['registeredOn'];
    profileImageUrl = json['profileImageUrl'];
    uid = json['uid'];
    mosqueKeeperUid = json['mosqueKeeperUid'];
    mosqueKeeperName = json['mosqueKeeperName'];
    mosqueKeeperEmail = json['mosqueKeeperEmail'];
    address =json['address'];
    isJamai =json['isJamai'];
    isMadrasa =json['isMadrasa'];
    isVerified =json['isVerified'];
    if (json['mosqueWitness'] != null) {
      mosqueWitness = List<UserModel>.from(
          json['mosqueWitness'].map((model) => UserModel.fromJson(model)))
          .toList();
    }
      prayerTiming =PrayerTimingModel.fromJson(json);
    latitude = json['latitude'];
    longitude = json['longitude'];
    token = json['token'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['registeredOn'] = this.registeredOn;
    data['profileImageUrl'] = this.profileImageUrl;
    data['uid'] = this.uid;
    data['prayerTiming'] = this.prayerTiming!.toJson();
    data['address'] = this.address;
    data['isMadrasa'] = this.isMadrasa;
    data['isJamai'] = this.isJamai;
    data['isVerified'] = this.isVerified;
    data['mosqueWitness'] = this.mosqueWitness?.map((user) => user.toJson()).toList();
    data['latitude'] = this.latitude;
    data['mosqueKeeperUid'] = this.mosqueKeeperUid;
    data['mosqueKeeperName'] = this.mosqueKeeperName;
    data['mosqueKeeperEmail'] = this.mosqueKeeperEmail;
    data['longitude'] = this.longitude;
    data['token'] = this.token;
    return data;
  }
}
