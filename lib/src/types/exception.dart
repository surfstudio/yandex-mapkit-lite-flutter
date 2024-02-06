part of yandex_mapkit_lite;

class YandexMapkitException implements Exception {}

abstract class SessionException implements YandexMapkitException {
  final String message;

  SessionException._(this.message);
}
