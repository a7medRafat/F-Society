import 'exception.dart';

enum NetworkErrorTypes { api, auth, firestore, storage }

abstract class MyFailure {
  String getMessage();
}

class CacheFailure extends MyFailure {
  @override
  String getMessage() => "error in cache";
}

class MyServerFailure extends MyFailure {
  final Exception error;

  MyServerFailure({
    required this.error,
  });

  String handleException(e) {
    String result;
    result = AuthExceptionHandler.generateExceptionMessage(
        AuthExceptionHandler.handleException(error));
    return result;
  }

  @override
  String getMessage() => handleException(error);
}
