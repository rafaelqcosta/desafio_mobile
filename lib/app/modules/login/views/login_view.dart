import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customTextFormField(
                key: 'inputEmail',
                label: 'e-mail',
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  return controller.validarEmail(value);
                },
                onChanged: (value) {
                  controller.email.value = value;
                },
              ),
              customTextFormField(
                key: 'inputSenha',
                label: 'senha',
                obscureText: true,
                maxLength: 12,
                validator: (value) {
                  return controller.validarSenha(value);
                },
                onChanged: (value) {
                  controller.senha.value = value;
                },
              ),
              Obx(
                () => Visibility(
                  key: Key('visibility'),
                  visible: controller.registrar.value,
                  child: customTextFormField(
                    key: 'inputConfirmarSenha',
                    label: 'confirmar senha',
                    obscureText: true,
                    maxLength: 12,
                    validator: (value) {
                      return controller.validarSenhaConfirmacao(value);
                    },
                    onChanged: (value) {
                      controller.senhaConfirmacao.value = value;
                    },
                  ),
                ),
              ),
              Obx(
                () => ElevatedButton(
                  key: Key('submitButton'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final submit = await controller.submit();
                      if (submit is String)
                        Get.rawSnackbar(
                          title: 'Erro:',
                          message: submit,
                          duration: Duration(seconds: 5),
                        );
                    }
                  },
                  child: Text(
                    controller.registrar.value ? 'Registrar' : 'Entrar',
                  ),
                ),
              ),
              Obx(
                () => TextButton(
                  key: Key('submitRegistrarButton'),
                  onPressed: () {
                    controller.registrar.toggle();
                  },
                  child: Text(controller.registrar.value
                      ? 'Cancelar'
                      : 'Registrar novo usuário.'),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget customTextFormField({
    required String key,
    required String label,
    required String? Function(String) validator,
    required Function(String) onChanged,
    bool? obscureText,
    int? maxLength,
    TextInputType? textInputType,
  }) {
    return TextFormField(
      key: Key(key),
      onChanged: (value) {
        onChanged(value);
      },
      validator: (value) {
        return validator(value!);
      },
      decoration: InputDecoration(
        label: Text(label),
      ),
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      maxLength: maxLength ?? 70,
      maxLines: 1,
    );
  }
}
