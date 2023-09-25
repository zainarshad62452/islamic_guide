import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Controllers/loading.dart';
import '../Models/MosqueModel.dart';
import '../models/userModel.dart';
import '../screens/widgets/snackbar.dart';
import '../services/Reception.dart';


class UserServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

   registerUser({required String name, required User user,String? address,String? contactNo}) async {
    var x = UserModel(
        name: name,
        email: user.email,
        registeredOn: Timestamp.now(),
        userType: "User",
        uid: user.uid,
    );
    try {
      await firestore.collection("users").doc(user.uid).set(x.toJson());
      loading(false);
      Reception().userReception();
    } catch (e) {
      loading(false);
      alertSnackbar("Can't register user");
    }
  }

  Stream<UserModel>? streamUser()  {
    try{
      return firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .snapshots()
          .map((event) {
        if(event.data()!=null){
          return UserModel.fromJson(event.data()!);
        }else{
          return UserModel();
        }
      });
    }catch(e){
      return null;
    }

  }
  Stream<UserModel>? streamSpecificUser(String id)  {
    try{
      return firestore
          .collection("users")
          .doc(id)
          .snapshots()
          .map((event) {
        if(event.data()!=null){
          print(UserModel.fromJson(event.data()!).name);
          return UserModel.fromJson(event.data()!);
        }else{
          return UserModel();
        }
      });
    }catch(e){
      return null;
    }

  }
  Stream<List<UserModel>>? streamAllAdmins() {
    try {
      return firestore.collection("users").snapshots().map((event) {
        loading(false);
        List<UserModel> list = [];
        event.docs.forEach((element) {
          final admin = UserModel.fromJson(element.data());
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
  bindMosque(MosqueModel id, bool isBind) async {
    try {
      loading(true);
      await firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
        "addedMosque":isBind?id.uid:""
      })
          .then((value)
          {
            List<String> mosqueWitness;
            if(id.mosqueWitness == null){
              mosqueWitness = [];
            }else{
              mosqueWitness = id.mosqueWitness!;
            }
            isBind?mosqueWitness.add(auth.currentUser!.uid):mosqueWitness.removeWhere((element) => element == auth.currentUser!.uid);
            firestore.collection("mosques").doc(id.uid).update(
              {
                "mosqueWitness": mosqueWitness,
              }
            ).then((value) => snackbar("Done",isBind?"Mosque has been binded successfully\nPlease Refresh.....":"Mosque has been unbinded successfully\nPlease Refresh.....")).onError((error, stackTrace)=>alertSnackbar("Error $error"));
          }
          ).onError((error, stackTrace)=>alertSnackbar("Error $error"));
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}
