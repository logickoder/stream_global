class AuthOtpState {
  final String? email;
  final String? error;
  final bool loading;

  const AuthOtpState({
    this.email,
    this.error,
    this.loading = false,
  });

  AuthOtpState copyWith({
    String? email,
    String? error,
    bool? loading,
  }) {
    return AuthOtpState(
      email: email ?? this.email,
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }
}
