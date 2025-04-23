import 'package:flutter/material.dart';
import 'package:login/features/authentication/screens/login/widgets/custom_phone_input.dart';
import 'package:login/utils/constants/sizes.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Custom Phone Number input
              CustomPhoneInput(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Confirm Button
              SizedBox(
                width: TSizes.buttonWidth,
                child: ElevatedButton(onPressed: () {}, child: Text("تأكيد")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
