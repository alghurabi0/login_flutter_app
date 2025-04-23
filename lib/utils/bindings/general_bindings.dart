import 'package:get/get.dart';
import 'package:login/data/repositories/authentication_repository.dart';
import 'package:login/data/services/api_service.dart';
import 'package:login/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationRepository());
    Get.put(NetworkManager());
    Get.put(ApiService());
  }
}
