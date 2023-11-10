import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_screen_state.dart';
import 'auth_type.dart';

class AuthScreenController extends AutoDisposeNotifier<AuthScreenState> {
  @override
  AuthScreenState build() => const AuthScreenState();

  Future<bool> submit({
    String? email,
    String? username,
    required AuthScreenType type,
  }) async {
    try {
      // state = state.copyWith(loading: true, error: null);
      // final (success, message) = switch (type) {
      //   AuthScreenType.login => await UserService.login(
      //     identifier: email!,
      //     password: password,
      //   ),
      //   AuthScreenType.register => await UserService.createAccount(
      //     username: username!,
      //     password: password,
      //   ),
      // };
      // if (!success) {
      //   setError(message);
      // }
      // return success;
      return true;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  void setError([String? error]) {
    state = state.copyWith(error: error);
  }
}
