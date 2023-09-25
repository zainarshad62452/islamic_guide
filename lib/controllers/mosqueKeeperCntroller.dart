import 'package:get/get.dart';
import 'package:islamic_guide/models/mosqueKeeperModel.dart';


import '../Services/mosqueKeeperServices.dart';



final mosqueKeeperCntr = Get.find<MosqueKeeperController>();

class MosqueKeeperController extends GetxController {
  Rx<MosqueKeeperModel>? user = MosqueKeeperModel().obs;
  RxList<MosqueKeeperModel>? allUsers = <MosqueKeeperModel>[].obs;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    user!.bindStream(MosqueKeeperServices().streamUser()!);
    allUsers!.bindStream(MosqueKeeperServices().streamAllAdmins()!);
  }
}
