import 'package:desafio/app/modules/login/controllers/login_controller.dart';
import 'package:desafio/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' as getx;
import 'package:get/route_manager.dart';

main() {
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
      'Deve apresentar os inputs e-mail e senha atribuir os valores as String email e senha no LoginController',
      (tester) async {
    //renderizar a View
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));

    //encontra os Texts renderizados
    final emailTextFormField = find.byWidgetPredicate((widget) {
      return textFormFieldMatcher(widget, 'inputEmail');
    });
    final senhaTextFormField = find.byWidgetPredicate((widget) {
      return textFormFieldMatcher(widget, 'inputSenha');
    });
    //realiza o text para saber se existe só um title renderizado
    expect(emailTextFormField, findsOneWidget);
    expect(senhaTextFormField, findsOneWidget);

    //Atribui um valor ao input
    await tester.enterText(emailTextFormField, 'xxx@xxx.com');
    expect(find.text('xxx@xxx.com'), findsOneWidget);
    await tester.enterText(senhaTextFormField, 'xxx');
    expect(find.text('xxx'), findsOneWidget);

    //Atribui um valor a String email no LoginController
    bool test = Get.isRegistered<LoginController>();
    expect(test, true);
    LoginController controller = getx.Get.find();
    expect(controller.email.value, 'xxx@xxx.com');
    expect(controller.senha.value, 'xxx');
  });

  testWidgets('Deve apresentar o button Entrar', (tester) async {
    await tester.pumpWidget(GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ));

    //encontra os Texts renderizados
    final button = find.text('Entrar');
    //realiza o text para saber se existe só um title renderizado
    expect(button, findsOneWidget);
  });
}

bool textFormFieldMatcher(Widget widget, key) {
  if (widget is TextFormField)
    return widget.key == Key(key);
  else
    return false;
}
