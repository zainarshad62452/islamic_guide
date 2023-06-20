import 'package:get/get.dart';
import 'package:islamic_guide/Models/MosqueModel.dart';
import '../Services/mosqueServices.dart';



final mosqueCntr = Get.find<MosqueController>();

class MosqueController extends GetxController {
  RxList<MosqueModel>? allItems = <MosqueModel>[].obs;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    allItems!.bindStream(MosqueServices().streamAllItems()!);
  }
}
