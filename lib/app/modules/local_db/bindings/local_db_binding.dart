import 'package:get/get.dart';

import '../controllers/local_db_controller.dart';

class LocalDbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalDbController>(
      () => LocalDbController(),
    );
  }
}
