import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login/data/repositories/authentication_repository.dart';
import 'package:login/firebase_options.dart';
import 'package:login/utils/bindings/general_bindings.dart';
import 'package:login/utils/theme/theme.dart';

void main() async {
  // Widgets Binding (if using native_splash_screen)
  // final WidgetsBinding widgetsBinding =
  //     WidgetsFlutterBinding.ensureInitialized();

  // Init local storage
  await GetStorage.init();

  // Init DB (Firestore)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

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
      home: CircularProgressIndicator(),
    );
  }
}
