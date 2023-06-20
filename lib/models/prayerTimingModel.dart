import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerTimingModel {
  String? uid;
  String? fajar;
  String? zuhur;
  String? asar;
  String? maghrib;
  String? isha;
  String? jummah;
  String? eid;
  String? token;

  PrayerTimingModel(
      {this.fajar,
        this.zuhur,
        this.asar,
        this.jummah,
        this.maghrib,
        this.uid,
        this.eid,
        this.token
      });

  PrayerTimingModel.fromJson(Map<String, dynamic> json) {
    fajar = json['fajar'];
    zuhur = json['zuhur'];
    asar = json['asar'];
    maghrib = json['maghrib'];
    isha = json['isha'];
    jummah = json['jummah'];
    eid =json['eid'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fajar'] = this.fajar;
    data['zuhur'] = this.zuhur;
    data['asar'] = this.asar;
    data['maghrib'] = this.maghrib;
    data['isha'] = this.isha;
    data['jummah'] = this.jummah;
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['eid'] = this.eid;
    return data;
  }
}
