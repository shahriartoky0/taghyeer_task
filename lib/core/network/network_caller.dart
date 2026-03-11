import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> _request(
      String method,
      String url, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
        bool isLogin = false,
      }) async {
    final Uri uri = Uri.parse(url);
    final Map<String, String> requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      ...?headers,
    };

    try {
      Response response;
      switch (method.toUpperCase()) {
        case 'POST':
          response = await post(uri, headers: requestHeaders, body: jsonEncode(body))
              .timeout(const Duration(seconds: 30));
          break;
        case 'GET':
          response = await get(uri, headers: requestHeaders)
              .timeout(const Duration(seconds: 30));
          break;
        case 'PUT':
          response = await put(uri, headers: requestHeaders, body: jsonEncode(body))
              .timeout(const Duration(seconds: 30));
          break;
        case 'DELETE':
          response = await delete(uri, headers: requestHeaders)
              .timeout(const Duration(seconds: 30));
          break;
        case 'PATCH':
          response = await patch(uri, headers: requestHeaders, body: jsonEncode(body))
              .timeout(const Duration(seconds: 30));
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }
      return _handleResponse(response, isLogin);
    } on SocketException {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: 'No internet connection. Please check your network.',
      );
    } catch (e) {
      debugPrint('NetworkCaller Error: $e');
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  NetworkResponse _handleResponse(Response response, bool isLogin) {
    try {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonResponse,
          statusCode: response.statusCode,
        );
      }
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        jsonResponse: jsonResponse,
        errorMessage: jsonResponse['message'] ?? 'Request failed',
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: 'Error parsing response: ${e.toString()}',
      );
    }
  }

  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false, Map<String, String>? headers}) =>
      _request('POST', url, body: body, isLogin: isLogin, headers: headers);

  Future<NetworkResponse> getRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false, Map<String, String>? headers}) =>
      _request('GET', url, body: body, isLogin: isLogin, headers: headers);

  Future<NetworkResponse> putRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false, Map<String, String>? headers}) =>
      _request('PUT', url, body: body, isLogin: isLogin, headers: headers);

  Future<NetworkResponse> deleteRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false, Map<String, String>? headers}) =>
      _request('DELETE', url, body: body, isLogin: isLogin, headers: headers);

  Future<NetworkResponse> patchRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false, Map<String, String>? headers}) =>
      _request('PATCH', url, body: body, isLogin: isLogin, headers: headers);
}
