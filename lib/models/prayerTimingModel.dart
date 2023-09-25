import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerTimingModel {
  String? fajar;
  String? zuhur;
  String? asar;
  String? maghrib;
  String? isha;
  String? jummah;

  PrayerTimingModel(
      {this.fajar,
        this.zuhur,
        this.asar,
        this.jummah,
        this.maghrib,
        this.isha,
      });

  PrayerTimingModel.fromJson(Map<String, dynamic> json) {
    fajar = json['fajar'];
    zuhur = json['zuhur'];
    asar = json['asar'];
    maghrib = json['maghrib'];
    isha = json['isha'];
    jummah = json['jummah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fajar'] = fajar;
    data['zuhur'] = zuhur;
    data['asar'] = asar;
    data['maghrib'] = maghrib;
    data['isha'] = isha;
    data['jummah'] = jummah;
    return data;
  }
}
