import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:islamic_guide/models/mosqueKeeperModel.dart';
import '../Controllers/loading.dart';
import '../screens/widgets/snackbar.dart';
import '../services/Reception.dart';


class MosqueKeeperServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  registerUser({required String name, required User user,String? address,String? contactNo}) async {
    var x = MosqueKeeperModel(
      name: name,
      email: user.email,
      registeredOn: Timestamp.now(),
      contactNo: contactNo,
      userType: "MosqueKeeper",
      uid: user.uid,
      address: address
    );
    try {
      await firestore.collection("mosque_keeper").doc(user.uid).set(x.toJson());
      loading(false);
      Reception().userReception();
    } catch (e) {
      loading(false);
      alertSnackbar("Can't register user");
    }
  }
  // startChatSendMessage({ required String reciver, required String type,required String groupChatId}) async {
  //
  //   try {
  //     var x = firestore.collection("donor").doc(FirebaseAuth.instance.currentUser?.uid)
  //         .collection(reciver)
  //         .doc(DateTime.now().millisecondsSinceEpoch.toString());
  //     // ChatModel chat = ChatModel(idFrom: donorCntr.user!.value.uid,idTo: reciver,timestamp: DateTime.now().millisecondsSinceEpoch.toString(),content: groupChatId);
  //     x.set(chat.toJson()).then((value) => print('done'));
  //   } catch (e) {
  //     alertSnackbar("Can't add Item");
  //   }
  // }

  Stream<MosqueKeeperModel>? streamUser()  {
    try{
      return firestore
          .collection("mosque_keeper")
          .doc(auth.currentUser!.uid)
          .snapshots()
          .map((event) {
        if(event.data()!=null){
          return MosqueKeeperModel.fromJson(event.data()!);
        }else{
          return MosqueKeeperModel();
        }
      });
    }catch(e){
      return null;
    }

  }
  Stream<List<MosqueKeeperModel>>? streamAllAdmins() {
    try {
      return firestore.collection("mosque_keeper").snapshots().map((event) {
        loading(false);
        List<MosqueKeeperModel> list = [];
        event.docs.forEach((element) {
          final admin = MosqueKeeperModel.fromJson(element.data());
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
}
