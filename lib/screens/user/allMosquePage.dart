import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_guide/Services/userServices.dart';
import 'package:islamic_guide/controllers/userController.dart';
import 'package:islamic_guide/screens/user/mainPage.dart';

import '../../Services/mosqueServices.dart';
import '../../controllers/mosqueController.dart';
import '../admin/mosqueDetails.dart';

class AllMosquesPage extends StatelessWidget {
  const AllMosquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Mosques"),
        backgroundColor: Colors.tealAccent.shade700,
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.only(top: 14),
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: mosqueCntr.allItems?.value.length,
              itemBuilder: (context, index) {
                var mosque = mosqueCntr.allItems?.value[index];
                if(!mosque!.isVerified!){
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ListTile(
                      onTap: (){
                        Get.to(MosqueDetails(model: mosque,));
                      },
                      leading: userCntr.user?.value.addedMosque!=null && userCntr.user?.value.addedMosque!=""?SizedBox():TextButton(onPressed: (){
                        showDialog(context: context, builder: (ctx)=>AlertDialog(
                          title: Text("Are you sure you want to bind Mosque(${mosque.name})?"),
                          actions: [
                            TextButton(onPressed: (){
                              showDialog(context: context, builder: (ctx)=>AlertDialog(content: Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:
                              [Text("Please wait..."),CircularProgressIndicator()],),),));
                              UserServices().bindMosque(mosque,true);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Yes")),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("No")),
                          ],
                        ));

                      }, child: Text("Bind")),
                      title: Text("Name: ${mosque.name!}"),
                      subtitle: Text("Mosque Keeper: ${mosque.mosqueKeeperName!}"),
                      trailing: Text("Address: ${mosque.address!}"),
                    ),
                  );
                }else{
                  return SizedBox();
                }

              },
            ),
          )
        ],
      ),
    );
  }
}
