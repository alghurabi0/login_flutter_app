import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/features/authentication/controllers/login_controller.dart';

class CustomPhoneInput extends StatelessWidget {
  const CustomPhoneInput({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo - change into instance;
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // visible numbers
        Text("00964780208"),
        // invisible numbers
        SizedBox(
          width: 90,
          child: TextFormField(
            controller: controller.lastFourDigits,
            decoration: InputDecoration(
              label: Text("XXXX"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
