import 'dart:async';

import 'package:desafio/app/modules/home/controllers/home_controller.dart';
import 'package:desafio/app/routes/app_pages.dart';
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
        title: Text(controller.user.value != null
            ? controller.user.value!.email!
            : 'Usuário não encontrado'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GoogleMap(
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
            TextButton.icon(
              icon: Icon(Icons.data_usage),
              onPressed: () {
                Get.toNamed(Routes.LOCAL_DB);
              },
              label: Text('Local DB'),
            ),
            TextButton.icon(
              icon: Icon(Icons.data_usage),
              onPressed: () {
                Get.toNamed(Routes.STORAGE_GLOBAL);
              },
              label: Text('Store Global'),
            ),
          ],
        ),
      ),
    );
  }
}
