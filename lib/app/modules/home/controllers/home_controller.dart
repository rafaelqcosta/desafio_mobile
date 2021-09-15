import 'dart:async';

import 'package:desafio/app/repositories/auth_repository.dart';
import 'package:desafio/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  /// Get.find recupera a instançia do AuthRepository
  final AuthRepository authRepository = Get.find();

  /// user - amazana informações do usuário logado
  late Rx<User?> user;

  /// loading - usada para rodar um CircularProgressor quando false
  final loading = true.obs;

  /// localizacaoAtual - armazana a posição atual do usuário
  /// por padrao ela está num ponto fixo mas pode ser alterada
  final localizacaoAtual = const LatLng(-15.8162561, -47.893234).obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    /// recupera as informações do usuário
    if (authRepository.userAuth != null) {
      user = authRepository.userAuth.obs;
    }

    await getLocalizacaoAtual();
  }

  /// realiza o logout do usuário e retorna ao LoginView
  logout() {
    authRepository.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  /// pega a localização atual utilizando o Geolocator
  Future getLocalizacaoAtual() async {
    loading(true);
    try {
      final geolocator = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      localizacaoAtual.value =
          LatLng(geolocator.latitude, geolocator.longitude);
    } catch (e) {
      print('Não foi possivel obter a localização atual!');
    }
    loading(false);
  }
}
