import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_otp_state.dart';

class AuthOtpController extends AutoDisposeNotifier<AuthOtpState> {
  @override
  AuthOtpState build() => const AuthOtpState();

  Future<void> sendOtp() async {
    try {
      state = state.copyWith(loading: true, error: null);
    } catch (e) {
      setError(e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<bool> verifyOtp({
    required String otp,
  }) async {
    try {
      state = state.copyWith(loading: true, error: null);
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
