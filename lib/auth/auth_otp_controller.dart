import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_otp_state.dart';

class AuthOtpController extends AutoDisposeNotifier<AuthOtpState> {
  @override
  AuthOtpState build() => const AuthOtpState();

  Future<void> sendOtp() async {
    try {
      state = state.copyWith(loading: true, error: null);
      // final (success, message) = await OtpService.sendOtp(
      //   email: state.email!,
      //   school: state.school,
      //   referralCode: state.referralCode,
      // );
      // if (!success) {
      //   setError(message);
      // }
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

      // final (token, message) = await OtpService.verifyOtp(
      //   email: state.email!,
      //   otp: otp,
      //   isPasswordReset: state.school == null,
      // );
      //
      // if (token == null) {
      //   setError(message);
      // }
      //
      // return token != null;
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
