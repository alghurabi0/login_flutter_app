import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login/features/authentication/screens/login/login.dart';
import 'package:login/utils/bindings/general_bindings.dart';
import 'package:login/utils/theme/theme.dart';

void main() async {
  // Widgets Binding (if using native_splash_screen)
  // final WidgetsBinding widgetsBinding =
  //     WidgetsFlutterBinding.ensureInitialized();

  // Init local storage
  await GetStorage.init();

  // Todo: DB (Firestore)
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "الموقف الاكتروني",
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: LoginScreen(),
    );
  }
}
