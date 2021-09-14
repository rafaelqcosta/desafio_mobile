import 'package:desafio/app/modules/home/bindings/home_binding.dart';
import 'package:desafio/app/modules/home/views/home_view.dart';
import 'package:desafio/app/modules/local_db/bindings/local_db_binding.dart';
import 'package:desafio/app/modules/local_db/views/local_db_view.dart';
import 'package:desafio/app/modules/login/bindings/login_binding.dart';
import 'package:desafio/app/modules/login/views/login_view.dart';
import 'package:desafio/app/modules/storage_global/bindings/storage_global_binding.dart';
import 'package:desafio/app/modules/storage_global/views/storage_global_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOCAL_DB,
      page: () => LocalDbView(),
      binding: LocalDbBinding(),
    ),
    GetPage(
      name: _Paths.STORAGE_GLOBAL,
      page: () => StorageGlobalView(),
      binding: StorageGlobalBinding(),
    ),
  ];
}
