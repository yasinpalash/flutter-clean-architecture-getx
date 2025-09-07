class ServerException implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  ServerException({
    required this.statusCode,
    required this.message,
    this.data,
  });

  @override
  String toString() => message;
}
