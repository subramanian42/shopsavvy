import 'dart:convert';

import 'package:http/http.dart' as http;

class NetWorkException implements Exception {
  int statuscode;
  String? message;
  NetWorkException(this.statuscode, {this.message});
}

class PunkApiClient {
  PunkApiClient({
    http.Client? httpClient,
    this.baseUrl = "api.punkapi.com",
    this.version = "/v2",
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;
  final String version;

  Future<List<dynamic>> fetchList(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    Uri uri = await _createUri(path, queryParams: queryParams);

    final response = await httpClient.get(
      uri,
    );

    return _handleResponse(response);
  }

  List<dynamic> _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode > 204) {
      throw NetWorkException(response.statusCode);
    }
    try {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body) as List;
      }
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }

  Future<Uri> _createUri(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    Map<String, String> params = {
      'per_page': "10",
    };
    if (queryParams != null) {
      params.addAll(queryParams);
    }

    final uri = Uri.https(baseUrl, version + path, params);
    return uri;
  }
}
