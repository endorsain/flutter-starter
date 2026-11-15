import '../domain/auth_repository.dart';

class DevelopmentAuthRepository implements AuthRepository {
  bool _hasSession = false;

  @override
  Future<bool> hasSession() async => _hasSession;

  @override
  Future<void> signIn({required String email, required String password}) async {
    _hasSession = true;
  }

  @override
  Future<void> signOut() async {
    _hasSession = false;
  }
}
