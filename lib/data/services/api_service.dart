import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:login/data/repositories/authentication_repository.dart';
import 'package:login/data/services/firestore_service.dart';
import 'package:login/features/authentication/screens/login/login.dart';
import 'package:login/utils/popups/loaders.dart';

class ApiService extends GetxController {
  static ApiService get instance => Get.find();

  final String _baseUrl = "https://dummyjson.com/";
  final http.Client _client;
  final localStorage = GetStorage();

  // List of excluded endpoints
  final Set<String> _excludedEndpoints = {'/auth/login', '/public/data'};

  ApiService(this._client);

  Future<http.Response> request(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl$endpoint');
      final requestHeaders = headers ?? {};

      // Apply middleware only if endpoint is not excluded
      if (!_excludedEndpoints.contains(endpoint)) {
        final shouldProceed = await applyMiddleware(
          AuthenticationRepository.instance.currentUser.id!,
        );
        if (!shouldProceed) {
          // remove local session id and log out user if session validation fails
          await localStorage.remove("SESSION_ID");
          await localStorage.remove("USER_ID");
          Get.offAll(() => LoginScreen());
        }
      }

      switch (method.toLowerCase()) {
        case 'get':
          return await _client.get(url, headers: requestHeaders);
        case 'post':
          return await _client.post(url, headers: requestHeaders, body: body);
        // Add other methods as needed
        default:
          throw UnsupportedError('Method $method not supported');
      }
    } catch (e) {
      // Handle any errors from middleware or request
      TLoaders.errorSnackBar(title: "حصل خطأ", message: e.toString());
      throw "Something Wrong Occured, Please try again later";
    }
  }

  // Middleware to validate session
  Future<bool> applyMiddleware(String userId) async {
    try {
      final localSessionId = await localStorage.read("SESSION_ID") ?? "";
      if (localSessionId == null || localSessionId == "") {
        return false; // No session ID found
      }

      final user = await FirestoreService.instance.fetchUserDetailsById(userId);
      if (user.sessionId != null && user.sessionId == localSessionId) {
        // Session is valid - add logic here
        return true;
      }

      return false; // Session validation failed
    } catch (e) {
      return false;
    }
  }
}
