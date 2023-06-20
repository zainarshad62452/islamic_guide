import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamic_guide/screens/auth/firebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_guide/firestore-data/appointmentHistoryList.dart';
import 'package:islamic_guide/screens/user/userSettings.dart';
class DoctorMainProfile extends StatefulWidget {
  const DoctorMainProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<DoctorMainProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection('doctors')
                .doc(user!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              var userData = snapshot.data;
              return ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.1, 0.5],
                                colors: [
                                  // Colors.indigo,
                                  // Colors.indigoAccent,
                                  Colors.tealAccent.shade700,
                                  Colors.tealAccent
                                ],
                              ),
                            ),
                            height: MediaQuery.of(context).size.height / 5,
                            child: Container(
                              padding: EdgeInsets.only(top: 10, right: 7),
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Get.to(()=>FireBaseAuth());
                                },
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height / 5,
                            padding: EdgeInsets.only(top: 75),
                            child: Text(
                              "Dr. "+user!.displayName!,
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/person.jpg'),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.teal[50]!,
                              width: 5,
                            ),
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.only(left: 20),
                    height: MediaQuery.of(context).size.height / 7,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey[50],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 27,
                                width: 27,
                                color: Colors.red[900],
                                child: Icon(
                                  Icons.mail_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user!.email!,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 27,
                                width: 27,
                                color: Colors.blue[800],
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user?.phoneNumber?.isEmpty ?? true
                                  ? "Not Added"
                                  : user!.phoneNumber!,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                    padding: EdgeInsets.only(left: 20, top: 20),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey[50],
                    ),
                    child:
                    Column(
                      children: [
                        Container(
                          child:  getData('address','No Address','Address',Colors.indigo[400]!)
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child:  getData('openHour','Add Open Hour','Open Hour',Colors.indigoAccent)
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child:  getData('closeHour','Add Close Hour','Close Hour', Colors.teal)
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child:  getData('rating','0','Rating',Colors.purple)
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child:  getData('specification','Add Specification','Specification',Colors.deepOrange)
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget getData(String value,String text,String title,Color color) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .doc(user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        var userData = snapshot.data;
        return
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 27,
                  width: 27,
                  color: color,
                  child: Icon(
                    // Icons.pencil_ent,
                    Icons.ac_unit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                  child:Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 40),
                    child: Text(
                      userData![value] == null ? text: userData[value].toString(),
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                      ),
                    ),
                  )
              ),
            ],
          );
      },
    );
  }
}
