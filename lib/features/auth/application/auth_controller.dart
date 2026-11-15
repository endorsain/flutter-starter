import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth_repository.dart';
import '../infrastructure/auth_repository_provider.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, bool>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<bool> {
  late AuthRepository _authRepository;

  @override
  Future<bool> build() async {
    _authRepository = ref.watch(authRepositoryProvider);
    return _authRepository.hasSession();
  }

  Future<void> signIn({required String email, required String password}) async {
    await _authRepository.signIn(email: email, password: password);
    state = const AsyncData<bool>(true);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = const AsyncData<bool>(false);
  }
}
