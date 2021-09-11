import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final email = ''.obs;
  final senha = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  String? validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "* Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "* Email inválido";
    } else {
      return null;
    }
  }

  String? validarSenha(String value) {
    String patttern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}$";
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "* Informe a senha";
    } else if (value.length < 6) {
      return "* Digite pelo menos 6 caracteres";
    } else if (!regExp.hasMatch(value)) {
      return "* A senha deve conter pelo menos 1 letra e 1 número";
    }
    return null;
  }
}
