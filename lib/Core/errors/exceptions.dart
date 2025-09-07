class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => message;
}

/// No internet connectivity
class NoInternetException extends NetworkException {
  const NoInternetException() : super("No Internet Connection");
}

/// Generic unexpected error
class UnexpectedException extends NetworkException {
  const UnexpectedException() : super("Unexpected error occurred");
}

/// Authentication error (401)
class UnauthorizedException extends NetworkException {
  const UnauthorizedException() : super("Unauthorized access");
}

/// Authorization error (403)
class ForbiddenException extends NetworkException {
  const ForbiddenException() : super("Access forbidden");
}

/// Resource not found (404)
class NotFoundException extends NetworkException {
  const NotFoundException() : super("Resource not found");
}

/// Server errors (500+)
class ServerErrorException extends NetworkException {
  const ServerErrorException([super.message = "Server error"]);
}

/// Request timed out
class TimeoutException extends NetworkException {
  const TimeoutException() : super("Connection timed out");
}

/// Request was cancelled
class CancelledException extends NetworkException {
  const CancelledException() : super("Request was cancelled");
}

/// Unknown or unclassified error
class UnknownNetworkException extends NetworkException {
  const UnknownNetworkException() : super("Unexpected network error occurred");
}
