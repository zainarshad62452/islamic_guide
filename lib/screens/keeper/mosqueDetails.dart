import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_guide/screens/keeper/updateTimings.dart';

import '../../Controllers/mosqueKeeperCntroller.dart';
import '../../Models/MosqueModel.dart';
import '../admin/mosqueLocationScreen.dart';
import 'addMosque.dart';

class MosqueDetailsUpdates extends StatelessWidget {
  MosqueDetailsUpdates({super.key,});
  TextStyle textStyle = TextStyle(
    fontSize: 30.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        title: Text("Mosque Details"),
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
            var model = MosqueModel.fromJson(snapshot.data!.data()!);
            return Column(
              children: [
                Text("Mosque Name: ${model.name}",style: textStyle,),
                Divider(),
                Text("Mosque Address: ${model.address}",style: textStyle,),
                Divider(),
                Text("Mosque Keeper Name: ${model.mosqueKeeperName}",style: textStyle,),
                Divider(),
                Text("Mosque Keeper Phone Number: ${model.mosqueKeeperPhone}",style: textStyle,),
                Divider(),
                Text("Mosque Type: ${model.mosqueType}",style: textStyle,),
                Divider(),
                Text("Prayer Timings",style: textStyle,),
                Text("Fajar : ${model.prayerTiming!.fajar}",style: textStyle,),
                Text("Duhur : ${model.prayerTiming!.zuhur}",style: textStyle,),
                Text("Asr : ${model.prayerTiming!.asar}",style: textStyle,),
                Text("Maghrib : ${model.prayerTiming!.maghrib}",style: textStyle,),
                Text("Isha : ${model.prayerTiming!.isha}",style: textStyle,),
                Text("Jumma : ${model.prayerTiming!.jummah}",style: textStyle,),
                Divider(),
                TextButton(onPressed: (){
                  Get.to(PrayerTimingPage());
                }, child: Text("Update Prayer Timings",style: textStyle,)),
                Divider(),
                TextButton(onPressed: (){
                  Get.to(LocationScreen(latitude: model.latitude!,longitude: model.longitude!,));
                }, child:  Text("Mosque Location Click Here!",style: textStyle,)),
              ],
            );
          }else{
            return Center(child: TextButton(onPressed: (){
              Get.to(RegisterMosque());
            }, child: Text("No Mosque Added!. Add Mosque")),);
          }
        },
      )
    );
  }
}
