import 'package:desafio/app/modules/login/controllers/login_controller.dart';
import 'package:desafio/app/repositories/auth_repository.dart';
import 'package:desafio/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' as getx;
import 'package:get/route_manager.dart';
import 'package:mockito/annotations.dart';

import 'login_view_flow_test.mocks.dart';

@GenerateMocks([AuthRepository])
main() async {
  final mockAuthRepository = MockAuthRepository();

  Get.create<AuthRepository>(
    () => MockAuthRepository(),
  );

  testWidgets('Deve apresentar o título', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));

    //encontra os Texts renderizados
    final titleFinder = find.text('Login');
    //realiza o text para saber se existe só um title renderizado
    expect(titleFinder, findsOneWidget);
  });

  testWidgets(
      'Deve apresentar o input email e atribuir um valor a String no LoginController',
      (tester) async {
    //renderizar a View
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));
    //Acha a instãcia do LoginController
    bool test = Get.isRegistered<LoginController>();
    expect(test, true);
    LoginController controller = getx.Get.find();
    //encontra os Texts renderizados
    final senhaTextFormField =
        find.byWidgetPredicate((widget) => keyMatcher(widget, 'inputEmail'));

    //realiza o teste para saber se existe só um email renderizado
    expect(senhaTextFormField, findsOneWidget);

    //Atribui um valor ao input
    await tester.enterText(senhaTextFormField, 'xxx@xxx.com');
    expect(find.text('xxx@xxx.com'), findsOneWidget);

    //Atribui um valor a String email no LoginController
    expect(controller.email.value, 'xxx@xxx.com');
  });

  testWidgets(
      'Deve apresentar o input senha e atribuir um valor a String no LoginController',
      (tester) async {
    //renderizar a View
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));
    //Acha a instãcia do LoginController
    bool test = Get.isRegistered<LoginController>();
    expect(test, true);
    LoginController controller = getx.Get.find();

    //encontra os Texts renderizados
    final senhaTextFormField =
        find.byWidgetPredicate((widget) => keyMatcher(widget, 'inputSenha'));
    //realiza o teste para saber se existe só uma senha renderizado
    expect(senhaTextFormField, findsOneWidget);

    //Atribui um valor ao input
    await tester.enterText(senhaTextFormField, 'input senha');
    expect(find.text('input senha'), findsOneWidget);

    //Atribui um valor a String senha no LoginController
    expect(controller.senha.value, 'input senha');
  });

  testWidgets(
      'Deve apresentar o inputConfirmarSenha e atribuir um valor a String no LoginController',
      (tester) async {
    //renderizar a View
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));
    //Acha a instância do LoginController
    bool test = Get.isRegistered<LoginController>();
    expect(test, true);
    LoginController controller = getx.Get.find();

    //Para localizar o inputConfirmarSenha é necessário que a variável regitrar seja true
    final visibility = find.byType(Visibility);
    expect(visibility, findsOneWidget);

    controller.registrar.value = true;
    await tester.pumpAndSettle();

    final senhaConfirmacaoTextFormField = find.byWidgetPredicate(
        (widget) => keyMatcher(widget, 'inputConfirmarSenha'));
    //realiza o test para saber se existe só um title renderizado
    expect(senhaConfirmacaoTextFormField, findsOneWidget);

    //Atribui um valor ao input
    await tester.enterText(senhaConfirmacaoTextFormField, 'confirmar');
    expect(find.text('confirmar'), findsOneWidget);

    //Atribui um valor a String senhaConfirmacao no LoginController
    expect(controller.senhaConfirmacao.value, 'confirmar');
  });

  testWidgets('Deve apresentar o submitButton', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));

    //Acha a instância do LoginController
    bool test = Get.isRegistered<LoginController>();
    expect(test, true);
    LoginController controller = getx.Get.find();

    //encontra os Texts renderizados
    final button =
        find.byWidgetPredicate((widget) => keyMatcher(widget, 'submitButton'));
    //realiza o text para saber se existe só um title renderizado
    expect(button, findsOneWidget);

    final buttonEntrar = find.text('Entrar');
    expect(buttonEntrar, findsOneWidget);

    //Para localizar o inputConfirmarSenha é necessário que a variável regitrar seja true
    controller.registrar.value = true;
    await tester.pumpAndSettle();

    final buttonRegistrar = find.text('Registrar');
    expect(buttonRegistrar, findsOneWidget);
  });

  testWidgets('Deve apresentar o TextButton submitRegistrarButton novo usuário',
      (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));

    //Acha a instância do LoginController
    bool test = Get.isRegistered<LoginController>();
    expect(test, true);
    LoginController controller = getx.Get.find();

    //encontra os Texts renderizados
    final button = find.byWidgetPredicate(
        (widget) => keyMatcher(widget, 'submitRegistrarButton'));
    //realiza o text para saber se existe só um title renderizado
    expect(button, findsOneWidget);

    final buttonEntrar = find.text('Registrar novo usuário.');
    expect(buttonEntrar, findsOneWidget);

    //Para localizar o inputConfirmarSenha é necessário que a variável regitrar seja true
    controller.registrar.value = true;
    await tester.pumpAndSettle();

    final buttonRegistrar = find.text('Cancelar');
    expect(buttonRegistrar, findsOneWidget);
  });
}

bool keyMatcher(Widget widget, key) {
  return widget.key == Key(key) ? true : false;
}
