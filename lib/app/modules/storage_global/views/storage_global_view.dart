import 'package:desafio/app/modules/storage_global/controllers/storage_global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorageGlobalView extends GetView<StorageGlobalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local DB'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(controller.email.value),
          ),
          Obx(
            () => Text(controller.uid.value),
          ),
          ElevatedButton(
            onPressed: () {
              controller.getCredenciais();
            },
            child: Text('Recuperar Credenciais Salvas'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.apagarCredenciais();
            },
            child: Text('Apagar Credenciais'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.salvarCredenciais();
            },
            child: Text('Salvar Credenciais'),
          ),
        ],
      )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await controller.createUsuario();
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
