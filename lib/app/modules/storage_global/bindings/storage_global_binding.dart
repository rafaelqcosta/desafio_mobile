import 'package:get/get.dart';

import '../controllers/storage_global_controller.dart';

class StorageGlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageGlobalController>(
      () => StorageGlobalController(),
    );
  }
}
