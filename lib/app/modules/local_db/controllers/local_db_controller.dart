import 'package:desafio/app/data/local_db.dart';
import 'package:desafio/app/models/usuario_model.dart';
import 'package:desafio/app/repositories/auth_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalDbController extends GetxController {
  LocalDB localDB = LocalDB();
  Rx<List<UsuarioModel>> usuarioList = Rx<List<UsuarioModel>>([]);
  final AuthRepository authRepository = Get.find();

  final loading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllUsuarios();
  }

  Future createUsuario() async {
    loading(true);
    final nextId = usuarioList.value.length + 1;
    final email =
        authRepository.userAuth != null ? authRepository.userAuth!.email! : '';
    final localizacao = await getLocalizacaoAtual();

    if (email != '') {
      final userModel =
          UsuarioModel(id: nextId, email: email, posicaoAtual: localizacao);
      await localDB.create(userModel);
    }
    await getAllUsuarios();
    loading(false);
  }

  Future updateUsuario() async {}

  Future getAllUsuarios() async {
    loading(true);
    usuarioList.value = await localDB.getUsuarios();
    loading(false);
  }

  Future deleteUsuario(int id) async {
    await localDB.delete(id);
  }

  Future<String> getLocalizacaoAtual() async {
    loading(true);
    try {
      final geolocator = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      loading(false);
      return LatLng(geolocator.latitude, geolocator.longitude).toString();
    } catch (e) {
      loading(false);
      print('Não foi possivel obter a localização atual!');
      rethrow;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
