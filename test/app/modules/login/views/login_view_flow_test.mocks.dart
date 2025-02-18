// Mocks generated by Mockito 5.0.15 from annotations
// in desafio/test/app/modules/login/views/login_view_flow_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:desafio/app/repositories/auth_repository.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeFirebaseAuth_0 extends _i1.Fake implements _i2.FirebaseAuth {}

class _FakeStreamSubscription_1<T> extends _i1.Fake
    implements _i3.StreamSubscription<T> {}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i4.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseAuth get auth => (super.noSuchMethod(Invocation.getter(#auth),
      returnValue: _FakeFirebaseAuth_0()) as _i2.FirebaseAuth);
  @override
  set auth(_i2.FirebaseAuth? _auth) =>
      super.noSuchMethod(Invocation.setter(#auth, _auth),
          returnValueForMissingStub: null);
  @override
  _i3.StreamSubscription<_i2.User?> get userStream =>
      (super.noSuchMethod(Invocation.getter(#userStream),
              returnValue: _FakeStreamSubscription_1<_i2.User?>())
          as _i3.StreamSubscription<_i2.User?>);
  @override
  set userStream(_i3.StreamSubscription<_i2.User?>? _userStream) =>
      super.noSuchMethod(Invocation.setter(#userStream, _userStream),
          returnValueForMissingStub: null);
  @override
  set userCredential(_i2.UserCredential? _userCredential) =>
      super.noSuchMethod(Invocation.setter(#userCredential, _userCredential),
          returnValueForMissingStub: null);
  @override
  set userAuth(_i2.User? _userAuth) =>
      super.noSuchMethod(Invocation.setter(#userAuth, _userAuth),
          returnValueForMissingStub: null);
  @override
  set preferences(_i5.SharedPreferences? _preferences) =>
      super.noSuchMethod(Invocation.setter(#preferences, _preferences),
          returnValueForMissingStub: null);
  @override
  _i3.Future<dynamic> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<dynamic>.value()) as _i3.Future<dynamic>);
  @override
  _i3.Future<_i2.UserCredential?> registrarUsuario(
          {String? email, String? senha}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #registrarUsuario, [], {#email: email, #senha: senha}),
              returnValue: Future<_i2.UserCredential?>.value())
          as _i3.Future<_i2.UserCredential?>);
  @override
  _i3.Future<_i2.UserCredential?> loginUsuario(
          {String? email, String? senha}) =>
      (super.noSuchMethod(
          Invocation.method(#loginUsuario, [], {#email: email, #senha: senha}),
          returnValue:
              Future<_i2.UserCredential?>.value()) as _i3
          .Future<_i2.UserCredential?>);
  @override
  String toString() => super.toString();
}
