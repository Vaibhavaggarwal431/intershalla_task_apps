
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intershalla_task_app/core/api/constant.dart';

String _getCookieHeader() {
  String cookie =
  _cookies.entries.map((entry) => '${entry.key}=${entry.value}').join('; ');
  return cookie;
}
Map<String, String> _cookies = {};

Future<T> getApiResponse<T>({
  required String endpoint,
  required T Function(Map<String, dynamic>) fromJson,
  Map<String, String>? headers,
  Object? params,
  bool? showError = false,
  bool? showLoading = false,
}) async {
  print("Calling API endpoint: $endpoint");
  print(" -> Payload: : ${params.toString()}");
  print(" -> Headers: : ${headers.toString()}");

  // Merge headers with the cookie header
  Map<String, String> mergedHeaders = {
    ...?headers,
    'Cookie': _getCookieHeader()
  };

  final Uri uri = Uri.parse(baseUrl + endpoint);
  final Uri uriWithParams =
  uri.replace(queryParameters: params as Map<String, String>?);

  final response = await http.get(uriWithParams, headers: mergedHeaders);

  print("Response code: ${response.statusCode}");
  print("Response data: ${response.body}");

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return fromJson(data);
  } else {
    if (showError != null && showError) {
      final Map<String, dynamic> errorData = json.decode(response.body);
      final errorMessage = errorData['msg'].toString();
      return Future.error(errorMessage);
    } else {
      throw Exception('Failed to load data');
    }
  }
}