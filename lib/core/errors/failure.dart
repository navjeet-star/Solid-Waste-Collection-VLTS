import 'package:equatable/equatable.dart';

/// Base Failure class for all errors in the application.
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({this.message = '', this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server or API failure
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server Failure', super.statusCode});
}

/// Cache or local storage failure
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache Failure', super.statusCode});
}

/// Network connectivity failure
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network Failure', super.statusCode});
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentication Failure', super.statusCode});
}

/// No data found failure
class NoDataFailure extends Failure {
  const NoDataFailure({super.message = 'No Data Found', super.statusCode});
}

/// Database failure
class DatabaseFailure extends Failure {
  const DatabaseFailure({super.message = 'Database Failure', super.statusCode});
}

