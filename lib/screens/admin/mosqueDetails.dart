import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_guide/Services/Reception.dart';
import 'package:islamic_guide/Services/userServices.dart';
import 'package:islamic_guide/controllers/userController.dart';

import '../../Models/MosqueModel.dart';
import '../user/mainPage.dart';
import 'mosqueLocationScreen.dart';

class MosqueDetails extends StatelessWidget {
  MosqueModel model;
   MosqueDetails({super.key,required this.model});
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Note:If a Mosque is not verified will not show on Map",),
            SizedBox(height: 30.0,),
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
            Text("Binded By: ${model.mosqueWitness!.length} Persons",style: textStyle,),
            Divider(),
            Text("Prayer Timings",style: textStyle,),
            Text("Fajar : ${model.prayerTiming!.fajar}",style: textStyle,),
            Text("Duhur : ${model.prayerTiming!.zuhur}",style: textStyle,),
            Text("Asr : ${model.prayerTiming!.asar}",style: textStyle,),
            Text("Maghrib : ${model.prayerTiming!.maghrib}",style: textStyle,),
            Text("Isha : ${model.prayerTiming!.isha}",style: textStyle,),
            Text("Jumma : ${model.prayerTiming!.jummah}",style: textStyle,),
            Divider(),
            Text("Status: ${model.isVerified! ?"Verified":"Not Verified"}",style: textStyle,),
            Divider(),
            TextButton(onPressed: (){
              Get.to(LocationScreen(latitude: model.latitude!,longitude: model.longitude!,));
            }, child:  Text("Mosque Location Click Here!",style: textStyle,)),
            FutureBuilder(
                future: Reception().fetchUserType(),
                builder: (ctx,value){
              if(value.data == "User"){
                if(userCntr.user?.value.addedMosque!=null && userCntr.user?.value.addedMosque!=""){
                  return TextButton(onPressed: (){
                    showDialog(context: context, builder: (ctx)=>AlertDialog(
                      title: Text("Are you sure you want to unbind mosque (${model.name})?"),
                      actions: [
                        TextButton(onPressed: (){
                          showDialog(context: context, builder: (ctx)=>AlertDialog(content: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                            [Text("Please wait..."),CircularProgressIndicator()],),),));
                          UserServices().bindMosque(model!,false);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, child: Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("No")),
                      ],
                    ));
                  }, child:  Text("UnBind Mosque",style: textStyle.copyWith(color: Colors.red),));
                } else{
                  return SizedBox();
                }
              }else{
                return SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }
}
