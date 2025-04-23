import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  Future<UserModel> loginWithUsernameAndPassword(
    String username,
    String password,
  ) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));

      // Check if username and password are correct
      if (username == "test" && password == "password") {
        return UserModel(
          username: username,
          password: password,
          phoneNumber: 009647802089950,
        );
      } else {
        throw Exception("Invalid username or password");
      }
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // [Phone Authentication] - Sign in
  Future<void> sendOTP(int phoneNumber) async {
    try {
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));

      // Check if phone number is valid
      if (phoneNumber == 009647802089950) {
        return;
      } else {
        throw Exception("Invalid phone number");
      }
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
