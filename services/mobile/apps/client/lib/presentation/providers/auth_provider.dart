import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final String? uid;
  final String? email;
  final String? idToken;

  AuthState({this.uid, this.email, this.idToken});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> setAuthInfo(User user) async {
    final idToken = await user.getIdToken();
    state = AuthState(uid: user.uid, email: user.email, idToken: idToken);
  }

  void signOut() {
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
