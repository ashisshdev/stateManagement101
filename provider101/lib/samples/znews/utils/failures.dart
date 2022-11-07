import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// In case of NoInternet
class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

/// In case of Response.statusCode != 200
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

/// In case of Local DB error
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}
