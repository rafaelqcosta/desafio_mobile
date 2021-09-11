import 'package:desafio/app/modules/home/bindings/home_binding.dart';
import 'package:desafio/app/modules/home/views/home_view.dart';
import 'package:desafio/app/modules/login/bindings/login_binding.dart';
import 'package:desafio/app/modules/login/views/login_view.dart';
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
  ];
}
