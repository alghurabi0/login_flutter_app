import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login/data/repositories/authentication_repository.dart';
import 'package:login/features/authentication/models/user_model.dart';
import 'package:login/features/authentication/screens/login/otp_verification.dart';
import 'package:login/features/authentication/screens/login/phone_auth.dart';
import 'package:login/features/other/screens/home_screen.dart';
import 'package:login/utils/helpers/network_manager.dart';
import 'package:login/utils/popups/full_screen_loader.dart';
import 'package:login/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Variables
  final localStorage = GetStorage();
  final hidePassword = true.obs;
  final rememberMe = true.obs;

  final username = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  String fullPhoneNumber = "";
  final lastFourDigits = TextEditingController();
  final otp = TextEditingController();

  final _auth = AuthenticationRepository.instance;

  // Username and Password SignIn
  Future<void> login() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog("Logging you in ...", "animation");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_USERNAME", username.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      // Log in user with username and password
      UserModel user = await _auth.loginWithUsernameAndPassword(username.text.trim(), password.text.trim());

      fullPhoneNumber = user.phoneNumber;

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect to phone authentication screen
      Get.to(() => PhoneAuthScreen(phoneNumber: fullPhoneNumber.substring(0, fullPhoneNumber.length - 4)));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "حصل خطأ", message: e.toString());
    }
  }

  // Confirm Last Four Digits
  Future<void> confirmLastFourDigits() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog("Confirming ...", "animation");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validation
      if (lastFourDigits.text.trim().length != 4) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "خطأ", message: "الرجاء ادخال 4 ارقام صحيحة");
        return;
      }
      if (lastFourDigits.text.trim() != fullPhoneNumber.substring(fullPhoneNumber.length - 4)) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "خطأ", message: "الرقم المدخل غير صحيح");
        return;
      }

      // Send OTP
      await _auth.sendOTP(fullPhoneNumber);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect to otp verification screen
      Get.to(() => OTPVerificationScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "حصل خطأ", message: e.toString());
    }
  }

  Future<void> verifyOTP() async {
    print("Verifying OTP: ${otp.text.trim()}");
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog("Verifying ...", "animation");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validation
      if (otp.text.trim().length != 6) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "خطأ", message: "الرجاء ادخال 6 ارقام صحيحة");
        return;
      }

      // Verify OTP
      await _auth.verifyOTP(otp.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect to home screen
      Get.offAll(() => HomeScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "حصل خطأ", message: e.toString());
    }
  }
}
