import 'package:desafio/app/data/store_global.dart';
import 'package:desafio/app/repositories/auth_repository.dart';
import 'package:get/get.dart';

class StorageGlobalController extends GetxController {
  StoreGlobal storageGlobal = StoreGlobal();
  final AuthRepository authRepository = Get.find();
  final email = ''.obs;
  final uid = ''.obs;

  final loading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  getCredenciais() async {
    email.value = await storageGlobal.getUserEmail() ?? '';
    uid.value = await storageGlobal.getUserUid() ?? '';
  }

  apagarCredenciais() async {
    await storageGlobal.apagarCredenciais();
    getCredenciais();
  }

  salvarCredenciais() async {
    await storageGlobal.salvarCredenciais(authRepository.userAuth!);
    getCredenciais();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
