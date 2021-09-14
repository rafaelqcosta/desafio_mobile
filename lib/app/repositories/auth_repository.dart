import 'dart:async';

import 'package:desafio/app/data/store_global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository  {
  FirebaseAuth auth = FirebaseAuth.instance;
  late StreamSubscription<User?> userStream;
  UserCredential? userCredential;
  User? userAuth;
  SharedPreferences? preferences;

  AuthRepository() {
    FirebaseAuth.instance.authStateChanges().listen((User? userStream) {
      if (userStream == null) {
        print('O usuário está desconectado!');
      } else {
        print('O usuário está logado!');
      }
    });
    userAuth = FirebaseAuth.instance.currentUser;
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential?> registrarUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);
      userAuth = userCredential!.user;

      // Salva dados do usuário store global
      StoreGlobal().salvarCredenciais(userAuth!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'A senha fornecida é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        throw 'A conta já existe para esse e-mail.';
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> loginUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      userAuth = userCredential!.user;

      // Salva dados do usuário store global
      StoreGlobal().salvarCredenciais(userAuth!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'Nenhum usuário encontrado para esse e-mail.';
      } else if (e.code == 'wrong-password') {
        throw 'Senha errada fornecida para esse usuário.';
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
