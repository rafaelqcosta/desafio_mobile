import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/repositories/auth_repository.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await initializeDefault();

  /// Cria a instância global do AuthRespoitory
  AuthRepository authRepository = Get.put(AuthRepository());

  /// Cria a instância Global do Analytics
  final FirebaseAnalytics analytics = Get.put(FirebaseAnalytics());

  /// Cria a instância Global do Analytics Obeservers
  final FirebaseAnalyticsObserver observer =
      Get.put(FirebaseAnalyticsObserver(analytics: analytics));

  runApp(
    GetMaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      title: "Desafio",
      getPages: AppPages.routes,
      initialRoute:

          /// Verifica se existe um usuário autenticado
          /// caso positivo vai direto para HomeView
          /// caso negativo vai para o LoginView
          authRepository.userAuth != null ? Routes.HOME : AppPages.INITIAL,
    ),
  );
}

Future<void> initializeDefault() async {
  try {
    /// Garante a inicialização
    WidgetsFlutterBinding.ensureInitialized();

    /// Define a orientação do app
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// Inicializa o Firebase
    FirebaseApp app = await Firebase.initializeApp();

    /// Cria a instância do Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  } catch (e) {
    print(e);
  }
}
