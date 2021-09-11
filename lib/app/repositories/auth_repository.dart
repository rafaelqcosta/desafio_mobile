import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepository extends GetxService {
  FirebaseAuth auth = FirebaseAuth.instance;
}
