import 'package:cloud_firestore/cloud_firestore.dart';

import '../errors/failures.dart';

const String SERVER_FAILURE_MESSAGE = 'please try again later';

const String EMPTY_CACHED_FAILURE_MESSAGE = 'no data';

const String FIRE_BASE_EXCEPTION = 'an expected error';

const String OFLINE_FAILURE_MESSAGE = 'please check your internet connection';


String REGISTER_ERROR = '';



String failureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case FirebaseException:
      return FIRE_BASE_EXCEPTION;
    case EmptyCacheFailure:
      return EMPTY_CACHED_FAILURE_MESSAGE;
    case OfflineFailure:
      return OFLINE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}