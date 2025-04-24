import 'package:get/get.dart';
import 'package:login/data/services/api_service.dart';
import 'package:login/data/services/firestore_service.dart';
import 'package:login/utils/helpers/network_manager.dart';
import 'package:http/http.dart' as http;

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(FirestoreService());
    Get.put(ApiService(http.Client()));
  }
}
