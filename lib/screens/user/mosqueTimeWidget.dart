import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_guide/screens/user/allMosquePage.dart';

import '../../Models/MosqueModel.dart';
import '../../controllers/userController.dart';
import '../keeper/addMosque.dart';

class MosqueTiming extends StatelessWidget {
  const MosqueTiming({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("mosques").doc(userCntr.user!.value.addedMosque).get(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }

        if(snapshot.hasError){
          return Center(child: Text("Something went wrong. Please try again!."),);
        }

        if(!snapshot.hasData){
          return Center(
            child: Text("No Data Available!."),
          );

        }
        if(snapshot.data!.data()!=null){
          var data = MosqueModel.fromJson(snapshot.data!.data()!);
          userCntr.bindedMosque.value = data;
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Masjid ${data.name}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    // color: Colors.blue[800],
                      color: Colors.tealAccent.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(height: 30.0,),
              ListTile(
                tileColor: Colors.black12,
                title: Text("Fajar"),
                trailing: Text(data.prayerTiming!.fajar!),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                tileColor: Colors.black12,
                title: Text("Dhuhr"),
                trailing: Text(data.prayerTiming!.zuhur!),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                tileColor: Colors.black12,
                title: Text("Asr"),
                trailing: Text(data.prayerTiming!.asar!),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                tileColor: Colors.black12,
                title: Text("Maghrib"),
                trailing: Text(data.prayerTiming!.maghrib!),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                tileColor: Colors.black12,
                title: Text("Isha"),
                trailing: Text(data.prayerTiming!.isha!),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                tileColor: Colors.black12,
                title: Text("Jummah"),
                trailing: Text(data.prayerTiming!.jummah!),
              ),
            ],
          );
        }else{
          return Center(child: TextButton(onPressed: (){
            Get.to(AllMosquesPage());
          }, child: Text("No Mosque Binded!. Bind Mosque")),);
        }
      },
    );
  }
}
