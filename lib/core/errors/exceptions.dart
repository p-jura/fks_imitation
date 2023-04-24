class ServerException implements Exception {
  final int? code;
  final String? message;

  ServerException([this.code, this.message]);
}
