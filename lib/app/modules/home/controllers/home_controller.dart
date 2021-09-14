import 'dart:async';

import 'package:desafio/app/repositories/auth_repository.dart';
import 'package:desafio/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final AuthRepository authRepository = Get.find();
  final count = 0.obs;
  late Rx<User?> user;
  final loading = true.obs;
  final localizacaoAtual = const LatLng(-15.8162561, -47.893234).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (authRepository.userAuth != null) {
      user = authRepository.userAuth.obs;
    }
    await getLocalizacaoAtual();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  logout() {
    authRepository.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

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
