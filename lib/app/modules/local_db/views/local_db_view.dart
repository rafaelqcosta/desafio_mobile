import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/local_db_controller.dart';

class LocalDbView extends GetView<LocalDbController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local DB'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: Get.width * 0.95,
          child: Obx(() {
            if (controller.loading.value) return CircularProgressIndicator();
            if (!controller.loading.value &&
                controller.usuarioList.value.isEmpty)
              return Container(
                child: Text('Não foi encontrado nenhum dado salvo.'),
              );
            else
              return ListView.builder(
                  itemCount: controller.usuarioList.value.length,
                  itemBuilder: (_, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                      ),
                      key: Key('dismissible$index'),
                      onDismissed: (DismissDirection direction) {
                        controller.deleteUsuario(
                            controller.usuarioList.value[index].id);
                      },
                      child: ListTile(
                        title: Text(
                            '${controller.usuarioList.value[index].id}: ${controller.usuarioList.value[index].email}'),
                        subtitle: Text(
                            controller.usuarioList.value[index].posicaoAtual),
                      ),
                    );
                  });
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.createUsuario();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
