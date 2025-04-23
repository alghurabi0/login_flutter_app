import 'package:get/get.dart';
import 'package:login/features/authentication/models/user_model.dart';

class ApiService extends GetxController {
  static ApiService get instance => Get.find();

  Future<UserModel> fetchUserDetails(String username, String password) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      // Check if username and password are correct
      if (username == "test" && password == "password") {
        return UserModel(username: username, phoneNumber: "009647802089950");
      }
      return UserModel.empty();
    } catch (e) {
      throw "المعلومات المدخلة غير صحيحة";
    }
  }
}
