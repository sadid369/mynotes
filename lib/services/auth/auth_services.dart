import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

class AuthServices implements AuthProvider {
  final AuthProvider providers;
  AuthServices(this.providers);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      providers.createUser(email: email, password: password);

  @override
  // TODO: implement currentUser
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
}
