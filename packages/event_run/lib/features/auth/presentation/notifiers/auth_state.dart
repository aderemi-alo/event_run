/// AuthState class
class AuthState {
  /// AuthState constructor
  const AuthState({this.isAuthenticated = false, this.isLoading = false});

  /// Whether the user is authenticated
  final bool isAuthenticated;

  /// When an auth action is in progress
  final bool isLoading;

  AuthState copyWith({bool? isAuthenticated, bool? isLoading}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
