import 'package:flutter/material.dart';
import 'package:login/features/authentication/controllers/login_controller.dart';

class CustomPhoneInput extends StatelessWidget {
  const CustomPhoneInput({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // visible numbers
        Text(phoneNumber),

        // invisible numbers
        SizedBox(
          width: 90,
          child: TextFormField(
            controller: controller.lastFourDigits,
            decoration: InputDecoration(label: Text("XXXX"), border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
