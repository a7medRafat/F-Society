import 'package:equatable/equatable.dart';

import '../handeling_error/exception.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [getMessage()];

  String getMessage() {
    throw UnimplementedError();
  }
}

class ServerFailure extends Failure {


}

class CacheFailure extends Failure {
  @override
  String getMessage() => "error in cache";
}

class FirebaseAuthFailure extends Failure {}

class OfflineFailure extends Failure {
  @override
  String getMessage() => "No internet connection";
}

class EmptyCacheFailure extends Failure {}

class MyServerFailure extends Failure {
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
