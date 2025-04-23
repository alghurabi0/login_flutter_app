import 'package:flutter/material.dart';
import 'package:login/features/authentication/screens/login/widgets/login_form.dart';
import 'package:login/utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
