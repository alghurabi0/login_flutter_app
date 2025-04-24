import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login/data/services/api_service.dart';
import 'package:login/data/services/firestore_service.dart';
import 'package:login/features/authentication/models/user_model.dart';
import 'package:login/features/authentication/screens/login/login.dart';
import 'package:login/features/other/screens/home_screen.dart';
import 'package:login/utils/helpers/helper_functions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final localStorage = GetStorage();
  UserModel currentUser = UserModel.empty();

  // Called from main.dart on launch
  @override
  void onReady() {
    screenRedirect();
  }

  // Function to show revelant screen
  screenRedirect() async {
    // Check if user id is in local storage
    final String userId = localStorage.read("USER_ID") ?? "";
    if (userId.isNotEmpty) {
      // Check if session id has been updated since last interaction
      final isLoggedIn = await ApiService.instance.applyMiddleware(userId);
      if (isLoggedIn) {
        currentUser = await FirestoreService.instance.fetchUserDetailsById(
          userId,
        );
        Get.offAll(() => HomeScreen());
      } else {
        // remove user_id and session_id from local storage and redirect to login screen
        await localStorage.remove("SESSION_ID");
        await localStorage.remove("USER_ID");
        Get.offAll(() => LoginScreen());
      }
    } else {
      // Redirect to login screen
      Get.offAll(() => LoginScreen());
    }
  }

  /* -------------------------------- Authentication ----------------------------*/
  // [Username and Password] - Sign in
  Future<UserModel> loginWithUsernameAndPassword(
    String username,
    String password,
  ) async {
    try {
      // Get user details from API
      final userDetails = await FirestoreService.instance.fetchUserDetails(
        username,
        password,
      );
      if (userDetails.username.isNotEmpty &&
          userDetails.phoneNumber.isNotEmpty) {
        // Save in authentication repository
        currentUser = userDetails;
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
        // Generate session id and store in local storage
        String sessionId = THelperFunctions.generateSessionId();
        localStorage.write("SESSION_ID", sessionId);

        localStorage.write("USER_ID", currentUser.id);

        // Store session id in user's Firestore document
        await FirestoreService.instance.updateUserDetails(
          UserModel(
            username: currentUser.username,
            phoneNumber: currentUser.phoneNumber,
            sessionId: sessionId,
          ),
        );
        return;
      } else {
        throw Exception("الرمز المدخل غير صحيح");
      }
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }

  // [Phone Authentication] - Logout
  Future<void> logout() async {
    try {
      // Remove session id and user id from local storage
      await localStorage.remove("SESSION_ID");
      await localStorage.remove("USER_ID");
      currentUser = UserModel.empty();
      return;
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
