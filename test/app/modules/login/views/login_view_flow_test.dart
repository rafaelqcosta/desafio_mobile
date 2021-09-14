import 'package:desafio/app/modules/login/controllers/login_controller.dart';
import 'package:desafio/app/modules/login/views/login_view.dart';
import 'package:desafio/app/repositories/auth_repository.dart';
import 'package:desafio/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_view_flow_test.mocks.dart';

@GenerateMocks([AuthRepository])
main() {
  testWidgets('Deve realizar o login', (tester) async {
    final mockAuthRepository = MockAuthRepository();

    final email = 'teste@teste.com';
    final senha = 'senha123';

    Get.create<AuthRepository>(
      () => MockAuthRepository(),
    );

    await tester.pumpWidget(
      GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );

    //Acha a instância do LoginController
    bool test = Get.isRegistered<LoginController>();
    expect(test, true);
    LoginController controller = Get.find();

    //1º passo - apresentar o LoginView
    final loginView = find.byType(LoginView);
    expect(loginView, findsOneWidget);

    //2º passo - digitar no campo o e-mail
    final emailTextFormField =
        find.byWidgetPredicate((widget) => keyMatcher(widget, 'inputEmail'));
    expect(emailTextFormField, findsOneWidget);
    await tester.enterText(emailTextFormField, email);

    //3º passo - digitar no campo o e-mail
    final senhaTextFormField =
        find.byWidgetPredicate((widget) => keyMatcher(widget, 'inputEmail'));
    expect(senhaTextFormField, findsOneWidget);
    await tester.enterText(senhaTextFormField, senha);

    //4º passo - Clicar no button Entrar
    final button =
        find.byWidgetPredicate((widget) => keyMatcher(widget, 'submitButton'));

    expect(button, findsOneWidget);

    final user = await credenciais();

    when(mockAuthRepository.loginUsuario(email: email, senha: senha))
        .thenAnswer((_) async => Future.value(user));

    // when(controller.submit()).thenAnswer((realInvocation) =>
    //     Future(() => Get.toNamed(Routes.HOME, arguments: user)));

    await tester.tap(button);

    await tester.pumpAndSettle();

    // // 5º passo - apresentar o LoginView
    // final homeView = find.byType(HomeView);
    // expect(homeView, findsOneWidget);
  });
}

Future<UserCredential?> credenciais() async {
  try {
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in.
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'teste@teste.com',
      displayName: 'Teste',
    );
    final auth = MockFirebaseAuth(mockUser: user);
    final userCredential = await auth.signInWithCredential(credential);
    return userCredential;
  } catch (e) {
    print('############# $e');
  }
}

bool keyMatcher(Widget widget, key) {
  return widget.key == Key(key) ? true : false;
}
