class AuthScreenState {
  final String? error;
  final bool loading;

  const AuthScreenState({this.error, this.loading = false});

  AuthScreenState copyWith({
    String? error,
    bool? loading,
  }) {
    return AuthScreenState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }
}
