import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login/data/repositories/authentication_repository.dart';
import 'package:login/features/authentication/models/user_model.dart';
import 'package:login/features/authentication/screens/login/phone_auth.dart';
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
  final lastFourDigits = TextEditingController();

  int fullPhoneNumber = 0;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

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
      UserModel user = await AuthenticationRepository.instance
          .loginWithUsernameAndPassword(
            username.text.trim(),
            password.text.trim(),
          );

      fullPhoneNumber = user.phoneNumber;

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect to phone authentication screen
      Get.to(() => PhoneAuthScreen());
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

      // TODO: Validation
      if (lastFourDigits.text.trim().length != 4) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Log in user with last four digits
      await AuthenticationRepository.instance.sendOTP(fullPhoneNumber);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect to otp verification screen
      Get.to(() => OTPVerificationScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "حصل خطأ", message: e.toString());
    }
  }
}
