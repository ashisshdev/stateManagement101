class AppException implements Exception {
  final String title;
  final String description;
  final int code;
  final String url;

  AppException({required this.title, required this.description, required this.code, required this.url});
}

/// those that are thrown from the server ///
// refer (last FAQ section)-> https://openweathermap.org/faq

/// Code 401
class ApiKeyException extends AppException {
  ApiKeyException({String? title, String? description, required int code, required String url})
      : super(
            title: "Invalid API Key",
            description: "Invalid Authorization key detected. Contact the developer.",
            code: code,
            url: url);
}

/// Code 404
class IncorrectQueryException extends AppException {
  IncorrectQueryException({String? title, String? description, required int code, required String url})
      : super(
            title: "Invalid Query",
            description: "Location does not exist. Try again with a different search term.",
            code: code,
            url: url);
}

/// Code 429
class FupLimitException extends AppException {
  FupLimitException({String? title, String? description, required int code, required String url})
      : super(
            title: "Fup Limit",
            description: "You have reached the limit for maximum calls on you Plan. Consider "
                "upgrading you subscription plan.",
            code: code,
            url: url);
}

// In case of timeOut that we ourself set
// OR
// code: 504 GatewayTimedOut
// The problem is the API server’s slow response
class ApiNotRespondingException extends AppException {
  ApiNotRespondingException({String? title, String? description, required int code, required String url})
      : super(title: "Server down", description: "Server took too long to respond.", code: code, url: url);
}

/// all other exceptions ///
class NoConnectionException extends AppException {
  NoConnectionException({String? title, String? description, required int code, required String url})
      : super(
            title: "No Internet.", description: "Unable to process, Check Internet Connection.", code: code, url: url);
}

class InvalidFormatException extends AppException {
  InvalidFormatException({String? title, String? description, required int code, required String url})
      : super(
            title: "Invalid request.",
            description: "Unable to process, something wrong with the API format.",
            code: code,
            url: url);
}

class UnknownException extends AppException {
  UnknownException({String? title, String? description, required int code, required String url})
      : super(
            title: "Unknown Error",
            description: "Unknown error encountered. Please try again later or contact developer.",
            code: code,
            url: url);
}
