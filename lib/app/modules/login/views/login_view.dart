import 'package:firebase_analytics/firebase_analytics.dart';
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
        /// título do appBar
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
              /// Input para informar o e-mail
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

              /// Input para informar a senha
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

              /// Input para informar a confirmação de senha
              /// caso controller.registrar.value seja true
              /// é envolvida num Obx para controlar a visibilidade do widget
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

              /// Botão para submeter as informações ao controller
              Obx(
                () => ElevatedButton(
                  key: Key('submitButton'),
                  onPressed: () async {
                    /// verifica a validação dos campos
                    if (_formKey.currentState!.validate()) {
                      /// Envia o click ao Analytics
                      FirebaseAnalytics().logEvent(
                        name: 'Click on Submit',
                      );

                      /// chama o método de login e em caso de erro
                      /// retorna uma String
                      final submit = await controller.submit();

                      /// caso retorne uma string apresenta a informação ao usuário
                      if (submit is String)
                        Get.rawSnackbar(
                          title: 'Erro:',
                          message: submit,
                          duration: Duration(seconds: 5),
                        );
                    }
                  },

                  /// Label do botão - muda de acordo com o controller.registrar.value
                  child: Text(
                    controller.registrar.value ? 'Registrar' : 'Entrar',
                  ),
                ),
              ),

              /// Botão de mudança da variável controller.registrar.value
              /// responsável por mudar o estado da view
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

  /// TextInput customizado
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
