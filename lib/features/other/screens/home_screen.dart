import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/features/authentication/controllers/login_controller.dart';
import 'package:login/features/other/controllers/home_controller.dart';
import 'package:login/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => loginController.logout(),
                    child: const Text('Logout'),
                  ),
                ),
                const SizedBox(height: 120),

                //
                Text("Welcome to the home screen"),
                const SizedBox(height: TSizes.spaceBtwItems),

                // Button to fetch a quote
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        controller.loading.value
                            ? null
                            : () => controller.fetchQuote(),
                    child:
                        controller.loading.value
                            ? const CircularProgressIndicator()
                            : const Text('Get Random Quote'),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Quote text
                Text(controller.quote.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
