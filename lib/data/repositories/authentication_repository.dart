import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login/data/services/api_service.dart';
import 'package:login/features/authentication/models/user_model.dart';
import 'package:login/features/authentication/screens/login/login.dart';
import 'package:login/features/other/screens/home_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final localStorage = GetStorage();
  // final _currentUser;

  // Called from main.dart on launch
  @override
  void onReady() {
    screenRedirect();
  }

  // Function to show revelant screen
  screenRedirect() async {
    // Check if user is logged in
    final isLoggedIn = localStorage.read("IS_LOGGED_IN") ?? false;
    if (isLoggedIn) {
      // Redirect to home screen
      Get.offAll(HomeScreen());
    } else {
      // Redirect to login screen
      Get.offAll(LoginScreen());
    }
  }

  /* -------------------------------- Authentication ----------------------------*/
  // [Username and Password] - Sign in
  Future<UserModel> loginWithUsernameAndPassword(String username, String password) async {
    try {
      // Get user details from API
      final userDetails = await ApiService.instance.fetchUserDetails(username, password);
      if (userDetails.username.isNotEmpty && userDetails.phoneNumber.isNotEmpty) {
        // Save user details to local storage
        // localStorage.write("IS_LOGGED_IN", true);
        // localStorage.write("USERNAME", userDetails.username);
        // localStorage.write("PHONE_NUMBER", userDetails.phoneNumber);

        return userDetails;
      } else {
        throw Exception("المعطيات المدخلة غير صحيحة");
      }
    } catch (e) {
      throw "المعطيات المدخلة غير صحيحة";
    }
  }

  // [Phone Authentication] - Send OTP
  Future<void> sendOTP(String phoneNumber) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      // Check if phone number is a valid Iraqi number
      if (phoneNumber.startsWith("00964") && phoneNumber.length == 15) {
        return;
      } else {
        throw Exception("الرقم المدخل غير صحيح");
      }
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // [Phone Authentication] - Verify OTP
  Future<void> verifyOTP(String otp) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 1));

      // Check if OTP is valid
      if (otp.length == 6) {
        return;
      } else {
        throw Exception("الرمز المدخل غير صحيح");
      }
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
