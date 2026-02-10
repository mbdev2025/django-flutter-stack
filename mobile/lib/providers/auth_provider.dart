import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(ref.read(apiServiceProvider));
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final ApiService _apiService;
  
  AuthNotifier(this._apiService) : super(const AsyncValue.data(null));
  
  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      await _apiService.login(username, password);
      final user = await _apiService.getProfile();
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> logout() async {
    try {
      await _apiService.logout();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> checkAuth() async {
    state = const AsyncValue.loading();
    try {
      final user = await _apiService.getProfile();
      state = AsyncValue.data(user);
    } catch (e) {
      state = const AsyncValue.data(null);
    }
  }
}
