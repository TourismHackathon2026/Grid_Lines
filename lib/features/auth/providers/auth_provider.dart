import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/user_model.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? error;
  final bool isLoading;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.error,
    this.isLoading = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1));
    state = AuthState(
      status: AuthStatus.authenticated,
      user: User(
        id: '1',
        name: 'Rajesh Hamal',
        email: email,
        role: 'tourist',
        createdAt: DateTime.now(),
      ),
      isLoading: false,
    );
  }

  Future<void> register(
      String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1));
    state = AuthState(
      status: AuthStatus.authenticated,
      user: User(
        id: '2',
        name: name,
        email: email,
        role: 'tourist',
        createdAt: DateTime.now(),
      ),
      isLoading: false,
    );
  }

  Future<void> logout() async {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void checkAuthStatus() {
    state = const AuthState(status: AuthStatus.unauthenticated);
    // In a real app, check SharedPreferences/secure storage for token
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier()..checkAuthStatus();
});
