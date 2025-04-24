import 'package:flutter/material.dart';
import 'package:login/features/authentication/controllers/login_controller.dart';
import 'package:login/utils/constants/sizes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: TSizes.appBarHeight * 2,
            right: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              // OTP Input
              PinCodeTextField(
                appContext: context,
                controller: controller.otp,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.verifyOTP(),
                  child: Text("تأكيد"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
