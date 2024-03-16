import 'dart:convert';
import 'dart:io';
import 'package:gym_fit/src/exceptions/httpException.dart';
import 'package:gym_fit/src/providers/auth.dart';
import 'package:gym_fit/src/providers/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BaseProvider {
  AuthProvider auth;
  late http.Client client;

  BaseProvider(this.auth, [http.Client? client]) {
    auth = auth;
    this.client = client ?? http.Client();
  }

  Map<String, String> getDefaultHeaders({includeAuth = false}) {
    final out = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.userAgentHeader: auth.getAppNameHeader(),
    };
    if (includeAuth) {
      out[HttpHeaders.authorizationHeader] = 'Bearer ${auth.token}';
    }
    return out;
  }

  Uri makeUrl(String path,
      {int? id, String? objectMethod, Map<String, dynamic>? query}) {
    return makeUri(auth.serverUrl!, path, id, objectMethod, query);
  }

  /// POSTs a new object
  Future<Map<String, dynamic>> post(Map<String, dynamic> data, Uri uri) async {
    final response = await client.post(
      uri,
      headers: getDefaultHeaders(includeAuth: true),
      body: json.encode(data),
    );

    // Something wrong with our request
    if (response.statusCode >= 400) {
      throw CustomHttpException(response.body);
    }

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> get(Uri uri) async {
    final response = await client.get(
      uri,
      headers: getDefaultHeaders(includeAuth: true),
    );

    // Something wrong with our request
    if (response.statusCode >= 400) {
      throw CustomHttpException(response.body);
    }

    return json.decode(response.body);
  }
}
