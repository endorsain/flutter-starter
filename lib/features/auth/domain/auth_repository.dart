abstract interface class AuthRepository {
  Future<bool> hasSession();

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();
}
