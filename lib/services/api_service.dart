import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chiventis/services/auth_service.dart';
import 'package:chiventis/ui/components/toast_message.dart';

class ApiService {
  static final String? _baseUrl = dotenv.env['BASE_URL'];
  static const baseEndpoint = '/api/v1';

  static Future<Map<String, String>> _getHeaders() async {
    final token = await AuthService.getToken();
    if (token != null) {
      return {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
    } else {
      return {
        'Accept': 'application/json',
      };
    }
  }

  static Future<Map<String, dynamic>> get(String endpoint,
      [Map<String, dynamic>? params]) async {
    final response = await http.get(
      Uri.https(_baseUrl!, baseEndpoint + endpoint, params),
      headers: await _getHeaders(),
    );
    print(response.statusCode);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      print(Uri.https(_baseUrl!, baseEndpoint + endpoint, params));
      print(await _getHeaders());
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> post(BuildContext context,
      String endpoint, Map<String, dynamic> data, String errorHeader) async {
    Map<String, String> headers = await _getHeaders();
    headers['Content-Type'] = 'application/json';
    final response = await http.post(
        Uri.https(_baseUrl!, baseEndpoint + endpoint),
        headers: headers,
        body: jsonEncode(data),
        encoding: Encoding.getByName('utf-8'));
    print('hererere');
    print(response.body);
    print(response.statusCode);
    print(Uri.https(_baseUrl!, baseEndpoint + endpoint));
    print(jsonEncode(data));
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(response.body)['succes'] == false ||
          jsonDecode(response.body)['status'] == false) {
        toastSuccess(
            context, errorHeader, jsonDecode(response.body)['message'], false);
      }
      return jsonDecode(response.body);
    } else {
      toastSuccess(
          context,
          errorHeader,
          jsonDecode(response.body)['errors'] != null
              ? jsonDecode(response.body)['errors']
                  [jsonDecode(response.body)['errors'].keys.first][0]
              : jsonDecode(response.body)['message'],
          false);
      return {
        'success': false,
        'message': jsonDecode(response.body)['errors'],
      };
    }
  }

  static Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> data) async {
    Map<String, String> headers = await _getHeaders();
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    final response = await http.put(
      Uri.https(_baseUrl!, baseEndpoint + endpoint),
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(
      Uri.https(_baseUrl!, baseEndpoint + endpoint),
      headers: await _getHeaders(),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
