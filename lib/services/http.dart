import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

const _headers = {
  "Accept": "application/json",
  "content-type": "application/json",
};

class HttpService {
  Connectivity connection = Connectivity();

  Future<dynamic> get(String url) async {
    final state = await connection.checkConnectivity();
    // TODO don't call method each time
    // create ConnectionService with single instance of Connectivity
    // put in Provider and listen to its onConnectivityChanged stream
    if (state == ConnectivityResult.none) {
      throw OfflineException();
    }
    final res = await http.get(Uri.parse(url), headers: _headers);
    return _handleResponse(res);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
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

class OfflineException extends BaseException {
  OfflineException() : super('');
}
