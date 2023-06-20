import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:islamic_guide/screens/auth/signIn.dart';
import 'package:islamic_guide/screens/user/mainPage.dart';
import '../Controllers/mosqueKeeperCntroller.dart';
import '../controllers/userController.dart';
import 'Authentication.dart';

class Reception {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future<String> fetchUserType() async {
    String type = "none";
    try {
      type = await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get()
            .then((value) => value['userType'].toString());
    } catch (e) {
      try {
        type = await firestore
            .collection("mosqueKeeper")
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => value['userType'].toString());
      } catch (e) {
        try{
          type = await firestore
              .collection("admin")
              .doc(auth.currentUser!.uid)
              .get()
              .then((value) => value['userType'].toString());
        }catch(e){
          return type;
        }
        return type;
      }
      return type;
    }
    return type;
  }

  userReception() async {
    final type = await fetchUserType();
    if(FirebaseAuth.instance.currentUser!=null){
      // if(!FirebaseAuth.instance.currentUser!.emailVerified){
      //   FirebaseAuth.instance.currentUser!.sendEmailVerification();
      //   // Get.to(()=>EmailVerification());
      // }else
        if (type == "User") {
          // Get.put(NeedyController());
          Get.put(UserController());
          // Get.put(MosqueKeeperController());
        Get.offAll(() => MainPage());

      } else if (type == "MosqueKeeper") {
        // Get.offAll(() => Dashboard());
        // Get.put(DonorController());
        // Get.put(NeedyController());
        // Get.put(VolunteerController());
          Get.put(UserController());
          // Get.put(MosqueKeeperController());
          Get.offAll(() => MainPage());
      }else if (type == "Admin") {
        // Get.offAll(() => VolunteerDashboard());
        // Get.put(VolunteerController());
        // Get.put(NeedyController());
        // Get.put(DonorController());
          Get.put(UserController());
          // Get.put(MosqueKeeperController());
          Get.offAll(() => MainPage());
      }else{
        Authentication().signOut();
      }
    }else{
      Get.offAll(() => SignIn());
    }
  }
}
