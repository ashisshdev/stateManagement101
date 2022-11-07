import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:provider101/samples/znews/utils/failures.dart';

class BaseHttp {
  final http.Client client;
  BaseHttp({required this.client});

  Future<http.Response> get(String url) async {
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw ServerFailure(response.statusCode.toString());
      }
    } on FormatException {
      throw const ServerFailure("Invalid Request.");
    } on SocketException {
      throw const ConnectionFailure("No Connection.");
    } on TimeoutException {
      throw const ConnectionFailure("Request Timeout.");
    }
  }
}
