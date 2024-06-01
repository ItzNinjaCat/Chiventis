import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_service.dart';

class AuthService {
  static const String _tokenKey = 'token';

  static const _storage = FlutterSecureStorage();

  static Future<bool> useFingerPrint(bool fingerPrint) async {
    await _storage.write(key: 'fingerPrint', value: fingerPrint.toString());
    return fingerPrint;
  }

  static Future<bool> getFingerPrint() async {
    final fingerPrint = await _storage.read(key: 'fingerPrint');
    return fingerPrint == 'true';
  }

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<Map<String, dynamic>> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await ApiService.post(
          context,
          '/login',
          {
            'email': email,
            'password': password,
          },
          'Failed to login');
      final token = response['token'] as String;
      await saveToken(token);

      return response;
    } catch (e) {
      return {'status': false};
    }
  }

  static Future<Map<String, dynamic>> register(
      BuildContext context,
      String email,
      String password,
      String passwordConfirmation,
      String firstName,
      String lastName,
      String phone) async {
    try {
      final response = await ApiService.post(
          context,
          '/register',
          {
            'email': email,
            'password': password,
            'password_confirmation': passwordConfirmation,
            'name': firstName,
            'lastname': lastName,
            'mobile': phone,
          },
          'Failed to register');
      return response;
    } catch (e) {
      print(e);
      return {'status': false};
    }
  }

  static Future<Map<String, dynamic>> forgotPassword(
      BuildContext context, String email) async {
    try {
      final response = await ApiService.post(context, '/forgot-password',
          {'email': email}, 'Failed to send forgot password request');
      return response;
    } catch (e) {
      return {'status': false};
    }
  }

  static Future<Map<String, dynamic>> getUser() async {
    try {
      print('123213123123123123');
      final response = await ApiService.get('/profile');
      return response['data'];
    } catch (e) {
      await clearToken();
      throw Exception('Failed to get user: $e');
    }
  }

  static Future<Map<String, dynamic>> verifyAccount(
      BuildContext context, String code, String email) async {
    try {
      final response = await ApiService.post(
          context,
          '/verify-account',
          {
            'code': code,
            'email': email,
          },
          'Failed to verify account');
      return response;
    } catch (e) {
      print(e);
      return {'status': false};
    }
  }

  static Future<Map<String, dynamic>> updatePassword(
      BuildContext context,
      String currentPassword,
      String newPassword,
      String confirmPassword) async {
    try {
      final response = await ApiService.post(
          context,
          '/update-password',
          {
            'current_password': currentPassword,
            'new_password': newPassword,
            'confirm_password': confirmPassword
          },
          'Failed to update password');

      return response;
    } catch (e) {
      print(e);
      //throw Exception('Failed to verify account: $e');
      return {'status': false};
    }
  }

  static Future<Map<String, dynamic>> verifyOTP(
      BuildContext context, String code, String email) async {
    try {
      final response = await ApiService.post(
          context,
          '/verify-otp',
          {
            'code': code,
            'email': email,
          },
          'Failed to verify OTP!');
      print(response);
      saveToken(response['token']);
      return response;
    } catch (e) {
      print(e);
      return {'status': false};
    }
  }

  static Future<Map<String, dynamic>> resetPassword(
      BuildContext context, String newPassword, String confirmPassword) async {
    try {
      final response = await ApiService.post(
          context,
          '/reset-password',
          {'password': newPassword, 'password_confirmation': confirmPassword},
          'Failed to update password');
      return response;
    } catch (e) {
      print(e);
      //throw Exception('Failed to verify account: $e');
      return {'status': false};
    }
  }
}
