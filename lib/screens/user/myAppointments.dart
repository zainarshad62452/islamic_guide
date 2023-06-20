import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_guide/firestore-data/myAppointmentList.dart';

class PrayerTiming extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Text("This is Prayer Timing Screen"),
        ),
      ),
    );
  }
}
