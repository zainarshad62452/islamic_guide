import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:islamic_guide/controllers/mosqueController.dart';
import 'package:islamic_guide/screens/auth/signIn.dart';
import 'package:islamic_guide/screens/user/mainPage.dart';
import '../Controllers/mosqueKeeperCntroller.dart';
import '../controllers/userController.dart';
import '../screens/admin/homePage.dart';
import '../screens/keeper/homePage.dart';
import '../screens/keeper/mainpage.dart';
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
            .collection("mosque_keeper")
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => value['userType'].toString());
      } catch (e) {
        return type;
      }
      return type;
    }
    return type;
  }

  userReception() async {
    final type = await fetchUserType();
    print(type);
    if(FirebaseAuth.instance.currentUser!=null){
      if (FirebaseAuth.instance.currentUser!.email == "admin@islamicguide.com") {
        Get.put(UserController());
        Get.put(MosqueKeeperController());
        Get.put(MosqueController());
        Get.offAll(() => AdminHomePage());

      }else if (type == "User") {
          Get.put(UserController());
        Get.offAll(() => MainPage());

      } else if (type == "MosqueKeeper") {
          Get.put(UserController());
          Get.put(MosqueKeeperController());
          Get.offAll(() => MosqueKeeperMainPage());
      }else{
        Authentication().signOut();
      }
    }else{
      Get.offAll(() => SignIn());
    }
  }
}
