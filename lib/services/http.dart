import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  Future<ServiceResponse> get(
    Uri uri, {
    Map<String, String> headers,
  }) async {
    final response = await http.get(
      uri,
    );
    print(response);
  }

  Map<String, String> _getHeaders() {
    return {
      "Accept": "application/json",
      "content-type": "application/json",
    };
  }

  ServiceResponse _handleResponse(http.Response response) {
    if (response.statusCode >= 200 || response.statusCode < 300) {
      if (response.body != null && response.body.length > 0) {
        return ServiceResponse.fromJson(
          jsonDecode(response.body),
        );
      }
      return ServiceResponse.fromJson("");
    } else {
      switch (response.statusCode) {
        case 400:
          throw Http400Exception(response);
        case 401:
          throw Http403Exception(response);
        case 403:
          throw Http403Exception(response);
        case 404:
          throw Http404Exception(response);
        case 409:
          throw Http409Exception(response);
        case 500:
          throw Http500Exception(response);
        default:
          throw UnknownException(response);
      }
    }
  }
}

class ServiceResponse {
  dynamic data;

  ServiceResponse.fromJson(json) {
    data = json;
  }
}

class BaseException implements Exception {
  BaseException(this.message);

  String message = '';

  @override
  String toString() => message;
}

class Http400Exception extends BaseException {
  Http400Exception(http.Response response) : super(response.body);
}

class Http403Exception extends BaseException {
  Http403Exception(http.Response response) : super(response.body);
}

class Http404Exception extends BaseException {
  Http404Exception(http.Response response) : super(response.body);
}

class Http409Exception extends BaseException {
  Http409Exception(http.Response response) : super(response.body);
}

class Http500Exception extends BaseException {
  Http500Exception(http.Response response) : super(response.body);
}

class UnknownException extends BaseException {
  UnknownException(http.Response response) : super(response.body);
}
