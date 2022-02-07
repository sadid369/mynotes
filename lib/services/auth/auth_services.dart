import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/firebase_auth_provider.dart';

class AuthServices implements AuthProvider {
  final AuthProvider providers;
  AuthServices(this.providers);
  factory AuthServices.firebase() {
    return AuthServices(FirebaseAuthProvider());
  }
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      providers.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => providers.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      providers.logIn(email: email, password: password);

  @override
  Future<void> logOut() => providers.logOut();

  @override
  Future<void> sendEmailVerification() => providers.sendEmailVerification();

  @override
  Future<void> initialize() => providers.initialize();
}
