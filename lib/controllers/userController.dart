import 'package:get/get.dart';
import '../Models/adminModel.dart';
import '../Services/needyServices.dart';
import '../models/userModel.dart';



final userCntr = Get.find<UserController>();

class UserController extends GetxController {
  Rx<UserModel>? user = UserModel().obs;
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
