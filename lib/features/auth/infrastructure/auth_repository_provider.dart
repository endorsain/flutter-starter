import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth_repository.dart';
import 'development_auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (kReleaseMode || kProfileMode) {
    return _UnavailableAuthRepository();
  }

  return DevelopmentAuthRepository();
});

class _UnavailableAuthRepository implements AuthRepository {
  @override
  Future<bool> hasSession() async => false;

  @override
  Future<void> signIn({required String email, required String password}) {
    throw StateError(
      'La autenticación simulada sólo está disponible en debug.',
    );
  }

  @override
  Future<void> signOut() async {}
}
