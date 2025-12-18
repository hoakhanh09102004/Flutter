import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  String? lastError;

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse("https://dummyjson.com/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          // Common token keys to check
          final altKeys = ['token', 'accessToken', 'access_token', 'jwt', 'session'];

          for (final k in altKeys) {
            if (decoded.containsKey(k) && decoded[k] != null) {
              // normalize to 'token' key for callers
              decoded['token'] = decoded[k];
              lastError = null;
              return decoded;
            }
          }

          // sometimes token is nested under 'data'
          if (decoded.containsKey('data') && decoded['data'] is Map<String, dynamic>) {
            final data = decoded['data'] as Map<String, dynamic>;
            for (final k in altKeys) {
              if (data.containsKey(k) && data[k] != null) {
                data['token'] = data[k];
                lastError = null;
                return data;
              }
            }
          }
        }

        // No token found despite 200 — include response in error for debugging
        lastError = 'Không nhận được token từ server';
        print('Login success but no token: ${response.body}');
        return null;
      } else {
        lastError = 'Sai tên đăng nhập hoặc mật khẩu!';
        print('Login failed (${response.statusCode}): ${response.body}');
        return null;
      }
    } catch (e) {
      lastError = 'Lỗi mạng: $e';
      return null;
    }
  }

  Future<Map<String, dynamic>?> getProfile(String token) async {
    final url = Uri.parse("https://dummyjson.com/auth/me");

    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Lỗi API: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Lỗi mạng: $e");
      return null;
    }
  }
}