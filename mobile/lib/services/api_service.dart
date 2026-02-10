import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';
import '../models/user.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
  
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Logique de rafraîchissement du token à implémenter ici
        }
        return handler.next(e);
      },
    ));
  }
  
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(ApiConfig.tokenEndpoint, data: {
        'username': username,
        'password': password,
      });
      
      await _storage.write(key: 'access_token', value: response.data['access']);
      await _storage.write(key: 'refresh_token', value: response.data['refresh']);
      
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<User> getProfile() async {
    try {
      final response = await _dio.get(ApiConfig.profileEndpoint);
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
