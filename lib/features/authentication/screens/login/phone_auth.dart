import 'package:flutter/material.dart';
import 'package:login/features/authentication/controllers/login_controller.dart';
import 'package:login/features/authentication/screens/login/widgets/custom_phone_input.dart';
import 'package:login/utils/constants/sizes.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Custom Phone Number input
              CustomPhoneInput(phoneNumber: phoneNumber),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Confirm Button
              SizedBox(
                width: TSizes.buttonWidth,
                child: ElevatedButton(onPressed: () => controller.confirmLastFourDigits(), child: Text("تأكيد")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
