import 'package:desafio/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late LoginController controller;

  setUp(() {
    controller = LoginController();
  });

  group('Validação E-mail -', () {
    test('Deve retornar Null se o email for digitado corretamente', () {
      final validarEmail = controller.validarEmail('xxx@xxx.com');
      expect(validarEmail, isNull);
    });
    test('Deve retornar uma String se o campo estiver vazio', () {
      final validarEmail = controller.validarEmail('');
      expect(validarEmail, equals('* Informe o Email'));
    });

    test('Deve retornar uma String se o email digitado estiver incompleto', () {
      final validarEmailSemArroba = controller.validarEmail('xxx_xxx.com');
      final validarEmailImcompleto = controller.validarEmail('xxx@xxx');
      expect(validarEmailSemArroba, equals('* Email inválido'));
      expect(validarEmailImcompleto, equals('* Email inválido'));
    });
  });

  group('Validação Senha -', () {
    test('Deve retornar Null se a senha for digitado corretamente', () {
      final validarEmail = controller.validarSenha('xxxxx1');
      expect(validarEmail, isNull);
    });
    test('Deve retornar uma String se a senha estiver vaiza', () {
      final validarEmail = controller.validarSenha('');
      expect(validarEmail, equals('* Informe a senha'));
    });
    test('Deve retornar uma String se não for digitado pelo menos 6 caracteres',
        () {
      final validarEmail = controller.validarSenha('xxx');
      expect(validarEmail, equals('* Digite pelo menos 6 caracteres'));
    });
    test('Deve retornar uma String se for digitado apenas letras', () {
      final validarEmail = controller.validarSenha('xxxxxx');
      expect(validarEmail,
          equals('* A senha deve conter pelo menos 1 letra e 1 número'));
    });
    test('Deve retornar uma String se for digitado apenas números', () {
      final validarEmail = controller.validarSenha('000000');
      expect(validarEmail,
          equals('* A senha deve conter pelo menos 1 letra e 1 número'));
    });
  });
}
