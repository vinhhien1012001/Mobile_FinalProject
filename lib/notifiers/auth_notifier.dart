import 'package:bloc/bloc.dart';
import 'package:final_project_mobile/pages/welcome.dart';
import 'package:final_project_mobile/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>(
    (ref) => AuthNotifier(ref.watch(authServiceProvider)));

class AuthNotifier extends StateNotifier<bool> {
  final AuthServices _authServices;
  final storage = const FlutterSecureStorage();
  AuthNotifier(this._authServices) : super(false);

  login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      state = true;

      await _authServices
          .login(email: email, password: password)
          .then((value) async {
        if (value != '') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
          state = false;
        }
      });
    } catch (e) {
      state = false;
    }
  }
}
