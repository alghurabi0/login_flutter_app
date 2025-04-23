import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:login/features/authentication/controllers/login_controller.dart';
import 'package:login/utils/constants/sizes.dart';
import 'package:login/utils/validators/validation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          /// Username
          TextFormField(
            controller: controller.username,
            validator: (value) => TValidator.validateUsername(value),
            decoration: InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed:
                      () =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Remember me
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Checkbox(
                  value: controller.rememberMe.value,
                  onChanged:
                      (value) =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                ),
              ),
              Text(
                "تذكر بياناتي ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Sign In Button
          SizedBox(
            width: TSizes.buttonWidth,
            child: ElevatedButton(
              onPressed: () => controller.login(),
              child: Text("تسجيل الدخول"),
            ),
          ),
        ],
      ),
    );
  }
}
