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
  String? mosqueKeeperPhone;
  String? mosqueType;
  bool? isVerified;
  List<String>? mosqueWitness;
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
        this.mosqueKeeperPhone,
        this.mosqueType,
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
    mosqueKeeperPhone = json['mosqueKeeperPhone'];
    address = json['address'];
    mosqueType = json['mosqueType'];
    isVerified = json['isVerified'];
    if (json['mosqueWitness'] != null) {
      mosqueWitness = List<String>.from(json['mosqueWitness']);
    }

    // Correctly access the prayerTiming field
    prayerTiming = json['prayerTiming'] != null ? PrayerTimingModel.fromJson(json['prayerTiming']) : null;

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
    data['mosqueType'] = this.mosqueType;
    data['isVerified'] = this.isVerified;
    data['mosqueWitness'] = this.mosqueWitness;
    data['latitude'] = this.latitude;
    data['mosqueKeeperUid'] = this.mosqueKeeperUid;
    data['mosqueKeeperName'] = this.mosqueKeeperName;
    data['mosqueKeeperPhone'] = this.mosqueKeeperPhone;
    data['longitude'] = this.longitude;
    data['token'] = this.token;
    return data;
  }
}
