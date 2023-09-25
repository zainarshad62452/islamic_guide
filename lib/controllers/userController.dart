import 'package:get/get.dart';
import 'package:islamic_guide/Models/MosqueModel.dart';
import '../Services/userServices.dart';
import '../models/userModel.dart';



final userCntr = Get.find<UserController>();

class UserController extends GetxController {
  Rx<UserModel>? user = UserModel().obs;
  Rx<MosqueModel> bindedMosque = MosqueModel().obs;
  RxList<UserModel>? allUsers = <UserModel>[].obs;
  @override
  void onReady() {
    initAdminStream();
  }



  initAdminStream() async {
    user!.bindStream(UserServices().streamUser()!);
    allUsers!.bindStream(UserServices().streamAllAdmins()!);
  }
}
