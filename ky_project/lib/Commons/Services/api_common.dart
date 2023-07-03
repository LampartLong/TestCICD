import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

abstract class CommonApiServices<T> {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  static var httpClient = HttpClient();

  // -------------------------------------------------------
  // Common functions. Continue...
  // -------------------------------------------------------

  // Post executor
  Future<T?> postExecutor(CommonApiRequest apiRequest) async {
    try {
      var response = await http.post(
        Uri.parse(apiRequest.uri),
        headers: apiRequest.requestHeaders,
        body: apiRequest.body,
      );

      return fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (exception) {
      rethrow;
    }
  }

  // Get executor
  Future<T?> getExecutor(CommonApiRequest apiRequest) async {
    try {
      var response = await http.get(
        Uri.parse(apiRequest.uri),
        headers: apiRequest.requestHeaders,
      );

      return fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (exception) {
      rethrow;
    }
  }

  // Put executor
  Future<T?> putExecutor(CommonApiRequest apiRequest) async {
    try {
      var response = await http.put(
        Uri.parse(apiRequest.uri),
        headers: apiRequest.requestHeaders,
        body: apiRequest.body,
      );

      return fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (exception) {
      rethrow;
    }
  }

  // Delete executor
  Future<T?> deleteExecutor(CommonApiRequest apiRequest) async {
    try {
      var response = await http.delete(
        Uri.parse(apiRequest.uri),
        headers: apiRequest.requestHeaders,
        body: apiRequest.body,
      );

      return fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (exception) {
      rethrow;
    }
  }

  T fromJson(json);
}

class CommonApiRequest {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  late Map<String, String> requestHeaders;
  late String uri;
  late String body;
}