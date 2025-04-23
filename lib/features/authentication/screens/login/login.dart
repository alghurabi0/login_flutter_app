import 'package:flutter/material.dart';
import 'package:login/common/styles/spacing_style.dart';
import 'package:login/features/authentication/screens/login/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            // Login Form
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
