import 'dart:async';

import 'package:desafio/app/modules/home/controllers/home_controller.dart';
import 'package:desafio/app/routes/app_pages.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.put(HomeController());
  Completer<GoogleMapController> mapController = Completer();

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        ///o título vem do AuthRepository caso seja null é informado ao usuário
        title: Text(controller.user.value != null
            ? controller.user.value!.email!
            : 'Usuário não encontrado'),
        centerTitle: true,
        actions: [
          ///botão para fazer logout e navegar para o LoginView
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body:

          ///Google Maps
          GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: controller.localizacaoAtual.value,
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///Botão para Navegar para LocalDBView
            TextButton.icon(
              icon: Icon(Icons.data_usage),
              onPressed: () {
                Get.toNamed(Routes.LOCAL_DB);
              },
              label: Text('Local DB'),
            ),

            ///Botão para Navegar para StorageGlobalView
            TextButton.icon(
              icon: Icon(Icons.data_usage),
              onPressed: () {
                Get.toNamed(Routes.STORAGE_GLOBAL);
              },
              label: Text('Store Global'),
            ),

            ///Botão para estourar um erro e enviar ao Crashlytics
            TextButton.icon(
              icon: Icon(Icons.error),
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              label: Text('Test Crashlytics'),
            ),
          ],
        ),
      ),
    );
  }
}
