import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islamic_guide/Controllers/mosqueKeeperCntroller.dart';
import 'package:islamic_guide/Models/MosqueModel.dart';
import 'package:islamic_guide/Services/mosqueServices.dart';
import 'package:islamic_guide/controllers/userController.dart';
import 'package:islamic_guide/models/prayerTimingModel.dart';

import 'addMosque.dart';


class PrayerTimingPage extends StatefulWidget {
  @override
  _PrayerTimingPageState createState() => _PrayerTimingPageState();
}

class _PrayerTimingPageState extends State<PrayerTimingPage> {
   RxList prayerTimings= [].obs;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        title: Text('Prayer Timings'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("mosques").doc(mosqueKeeperCntr.user!.value.addedMosque).get(),
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
            return Column(
              children: [
                Text("Note: Click To Update the Timings"),
                SizedBox(height: 30.0,),
                ListTile(
                  tileColor: Colors.black12,
                  onTap: () async {
                    String value = await _showTimePicker(data.prayerTiming!.fajar!);
                    PrayerTimingModel prayerModel = data.prayerTiming!;
                    prayerModel.fajar= value;
                    showDialog(context: context, builder: (ctx)=>AlertDialog(
                      title: Text("Confirmation"),
                      content: Text('Do you want to change time to ${prayerModel.fajar}'),
                      actions: [
                        TextButton(onPressed: (){

                          MosqueServices().updateTimings(mosqueKeeperCntr.user!.value.addedMosque!,prayerModel);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel")),
                      ],
                    ));
                  },
                  title: Text("Fajar"),
                  trailing: Text(data.prayerTiming!.fajar!),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  tileColor: Colors.black12,
                  onTap: () async {
                    String value = await _showTimePicker(data.prayerTiming!.zuhur!);
                    PrayerTimingModel prayerModel = data.prayerTiming!;
                    prayerModel.zuhur= value;
                    showDialog(context: context, builder: (ctx)=>AlertDialog(
                      title: Text("Confirmation"),
                      content: Text('Do you want to change time to ${prayerModel.zuhur}'),
                      actions: [
                        TextButton(onPressed: (){

                          MosqueServices().updateTimings(mosqueKeeperCntr.user!.value.addedMosque!,prayerModel);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel")),
                      ],
                    ));
                  },
                  title: Text("Dhuhr"),
                  trailing: Text(data.prayerTiming!.zuhur!),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  tileColor: Colors.black12,
                  onTap: () async {
                    String value = await _showTimePicker(data.prayerTiming!.asar!);
                    PrayerTimingModel prayerModel = data.prayerTiming!;
                    prayerModel.asar= value;
                    showDialog(context: context, builder: (ctx)=>AlertDialog(
                      title: Text("Confirmation"),
                      content: Text('Do you want to change time to ${prayerModel.asar}'),
                      actions: [
                        TextButton(onPressed: (){

                          MosqueServices().updateTimings(mosqueKeeperCntr.user!.value.addedMosque!,prayerModel);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel")),
                      ],
                    ));
                  },
                  title: Text("Asr"),
                  trailing: Text(data.prayerTiming!.asar!),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  tileColor: Colors.black12,
                  onTap: () async {
                    String value = await _showTimePicker(data.prayerTiming!.maghrib!);
                    PrayerTimingModel prayerModel = data.prayerTiming!;
                    prayerModel.maghrib= value;
                    showDialog(context: context, builder: (ctx)=>AlertDialog(
                      title: Text("Confirmation"),
                      content: Text('Do you want to change time to ${prayerModel.maghrib}'),
                      actions: [
                        TextButton(onPressed: (){

                          MosqueServices().updateTimings(mosqueKeeperCntr.user!.value.addedMosque!,prayerModel);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel")),
                      ],
                    ));
                  },
                  title: Text("Maghrib"),
                  trailing: Text(data.prayerTiming!.maghrib!),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  tileColor: Colors.black12,
                  onTap: () async {
                    String value = await _showTimePicker(data.prayerTiming!.isha!);
                    PrayerTimingModel prayerModel = data.prayerTiming!;
                    prayerModel.isha= value;
                    showDialog(context: context, builder: (ctx)=>AlertDialog(
                      title: Text("Confirmation"),
                      content: Text('Do you want to change time to ${prayerModel.isha}'),
                      actions: [
                        TextButton(onPressed: (){

                          MosqueServices().updateTimings(mosqueKeeperCntr.user!.value.addedMosque!,prayerModel);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel")),
                      ],
                    ));
                  },
                  title: Text("Ishq"),
                  trailing: Text(data.prayerTiming!.isha!),
                ),
                SizedBox(height: 10.0,),
                ListTile(
                  tileColor: Colors.black12,
                  onTap: () async {
                    String value = await _showTimePicker(data.prayerTiming!.jummah!);
                    PrayerTimingModel prayerModel = data.prayerTiming!;
                    prayerModel.jummah= value;
                    showDialog(context: context, builder: (ctx)=>AlertDialog(
                      title: Text("Confirmation"),
                      content: Text('Do you want to change time from ${data.prayerTiming!.jummah} to ${prayerModel.jummah}'),
                      actions: [
                        TextButton(onPressed: (){

                          MosqueServices().updateTimings(mosqueKeeperCntr.user!.value.addedMosque!,prayerModel);
                          Navigator.pop(context);
                          setState(() {

                          });
                        }, child: Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel")),
                      ],
                    ));
                  },
                  title: Text("Jummah"),
                  trailing: Text(data.prayerTiming!.jummah!),
                ),
              ],
            );
          }else{
            return Center(child: TextButton(onPressed: (){
              Get.to(RegisterMosque());
            }, child: Text("No Mosque Added!. Add Mosque")),);
          }
        },
      ),
    ));
  }

   Future<String> _showTimePicker(String index) async {
     TimeOfDay? selectedTime = await showTimePicker(
       context: context,
       initialTime: TimeOfDay.fromDateTime(
         DateFormat.Hm().parse(index),
       ),
     );
       return '${selectedTime?.hour}:${selectedTime?.minute}';
   }
}
