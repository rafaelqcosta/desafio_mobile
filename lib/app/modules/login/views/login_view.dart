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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //TODO
                  }
                },
                child: Text('Entrar'),
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
