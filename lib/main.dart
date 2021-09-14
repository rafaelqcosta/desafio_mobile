import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/repositories/auth_repository.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await initializeDefault();

  AuthRepository authRepository = Get.put(AuthRepository());

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute:
          authRepository.userAuth != null ? Routes.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> initializeDefault() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    FirebaseApp app = await Firebase.initializeApp();
    print('Firebase inicializado: $app');
  } catch (e) {
    print(e);
  }
}
