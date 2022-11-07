import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../utils/api_details.dart';
import 'app_exceptions.dart';

class Server {
  final http.Client client;
  Server({required this.client});

  Future<http.Response> get({required String city}) async {
    Uri uri = Uri.parse("${baseUrl}q=$city&appid=$appid");
    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await client.get(uri);
      // int errorCodeInJson = int.parse(jsonDecode(response.body)['cod'].toString());
      return handleResponse(response);
    } on SocketException {
      throw NoConnectionException(code: 0, url: "No Url");
    } on TimeoutException {
      throw NoConnectionException(code: 0, url: "No Url");
    } on FormatException {
      throw InvalidFormatException(code: 0, url: "No Url");
    }
  }
}

Future<http.Response> handleResponse(http.Response response) async {
  switch (response.statusCode) {
    case 200:
      return response;
    case 401:
      throw ApiKeyException(url: response.request?.url.path.toString() ?? "No Url", code: 401);
    case 404:
      throw IncorrectQueryException(url: response.request?.url.path.toString() ?? "No Url", code: 404);
    case 429:
      throw FupLimitException(url: response.request?.url.path.toString() ?? "No Url", code: 429);
    case 500:
    case 502:
    case 503:
    case 504:
      throw ApiNotRespondingException(url: response.request?.url.path.toString() ?? "No Url", code: 500);
    default:
      throw UnknownException(url: "inside catch method", code: 0);
  }
}
