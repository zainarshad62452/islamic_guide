import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:islamic_guide/Controllers/mosqueKeeperCntroller.dart';
import 'package:islamic_guide/controllers/mosqueController.dart';
import 'package:islamic_guide/models/mosqueKeeperModel.dart';
import 'package:islamic_guide/models/prayerTimingModel.dart';
import 'package:islamic_guide/screens/keeper/homePage.dart';
import '../Controllers/loading.dart';
import '../Models/MosqueModel.dart';
import '../screens/keeper/mainpage.dart';
import '../screens/widgets/snackbar.dart';
import 'NotificationServices.dart';

class MosqueServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  registerMosque({required String name, String? mosquePic,PrayerTimingModel? prayerTiming,String? location,double? longitude,double? latitude,String? mosqueType,}) async {
    loading(true);
    var x = MosqueModel(
        name: name,
        registeredOn: Timestamp.now(),
        mosqueKeeperName: mosqueKeeperCntr.user?.value.name,
        mosqueKeeperUid: auth.currentUser!.uid,
        mosqueKeeperPhone: mosqueKeeperCntr.user?.value.contactNo,
        profileImageUrl: mosquePic,
      address: location,
      longitude: longitude,
      latitude: latitude,
        prayerTiming: prayerTiming,
      mosqueType: mosqueType,
      isVerified: false,
    );
    try {
      final user = firestore.collection("mosques").doc();
      x.uid = user.id;
      user.set(x.toJson()).then((value) {
        firestore.collection('mosque_keeper').doc(auth.currentUser?.uid).update(
          {
            'photoURL':x.uid
          }
        ).then((value) {
          Get.offAll((MosqueKeeperMainPage()));
          snackbar("Done", "Mosque has been registered successfully and sent for review");
        });
      });

      loading(false);
    } catch (e) {
      loading(false);
      alertSnackbar("Can't add Mosque");
    }
  }

  // Stream<ItemModel> streamItem()  {
  //   return  firestore
  //       .collection("items")
  //       .doc(auth.currentUser!.uid)
  //       .snapshots()
  //       .map((event) => ItemModel.fromJson(event.data()!));
  // }
  Stream<List<MosqueModel>>? streamAllItems() {
    try {
      return firestore.collection("mosques").snapshots().map((event) {
        loading(false);
        List<MosqueModel> list = [];
        event.docs.forEach((element) {
          final admin = MosqueModel.fromJson(element.data());
          list.add(admin);
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }
  update(MosqueModel item,String index,String Value,String title) async {
    try {
      loading(true);
      print(Value);
      await firestore
          .collection("mosques")
          .doc(item.uid)
          .update({"$index": "$Value"})
      .then((value) =>alertSnackbar("$title")).onError((error, stackTrace)=>alertSnackbar("Error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
  approveMosque(String item,) async {
    try {
      loading(true);
      print(Value);
      await firestore
          .collection("mosques")
          .doc(item)
          .update({"isVerified": true})
          .then((value) =>snackbar("Done","Successfully Approved!!")).onError((error, stackTrace)=>alertSnackbar("Error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
  updateTimings(String item,PrayerTimingModel value) async {
    try {
      loading(true);
      print(value);
      print(item);

      await firestore
          .collection("mosques")
          .doc(item)
          .update({"prayerTiming": value.toJson()})
          .then((value) =>snackbar("Done","Successfully Update!!")).onError((error, stackTrace)=>alertSnackbar("Error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  // resurve(MosqueModel item,String? email,MosqueModel? user) async {
  //   try {
  //     loading(true);
  //     await firestore
  //         .collection("mosques")
  //         .doc(item.uid)
  //         .update({"resurved": true,"resurvedByUid":FirebaseAuth.instance.currentUser?.uid,"resurvedBy": "$email","reservedStatus": "${foodStatus.readyToCollect}","reservedLatitude":user?.latitude,"reservedLongitude":user?.longitude})
  //         .then((value) async {
  //       // DocumentSnapshot snap = await firestore.collection('donor').doc(item.postBy).get();
  //       // String token = snap['token'];
  //       // NotificationServices().sendPushMessage(token, 'The user ${needyCntr.user!.value.email} have reserved the food', 'Food Reserved');
  //       // snackbar("Done", "Successfully Reserved The Food");
  //     }).onError((error, stackTrace)=>alertSnackbar("Error $error"));
  //     loading(false);
  //   } catch (e) {
  //     loading(false);
  //   }
  // }
  updateInt(MosqueModel item,String index,int Value) async {
    try {
      loading(true);
      print(Value);
      await firestore
          .collection("mosques")
          .doc(item.uid)
          .update({"$index": Value})
      .then((value) => {alertSnackbar("Successfully Changed")}).onError((error, stackTrace) => alertSnackbar("Error this is error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  delete(MosqueModel item,) async {
    try {
      // loading(true);
      await firestore
          .collection("posts")
          .doc(item.uid)
          .delete().then((value) => {print("Successfully Deleted,\nRefresh To see Changes")});
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}

