import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:login/data/services/api_service.dart';
import 'package:login/utils/helpers/network_manager.dart';
import 'package:login/utils/popups/loaders.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final api = ApiService.instance;

  RxString quote = "".obs;
  RxBool loading = false.obs;

  Future<void> fetchQuote() async {
    try {
      // Start Loading
      loading.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        loading.value = false;
        return;
      }

      // Generate a random number between 1 and 99
      final random = Random();
      final randomId = random.nextInt(99) + 1; // 1-99

      final response = await api.request('GET', 'quotes/$randomId');

      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        quote.value = data['quote'] ?? "No quote Found";
      } else {
        throw 'Failed to fetch quote: ${response.statusCode}';
      }

      // Remove Loader
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: "حصل خطأ", message: e.toString());
    }
  }
}
