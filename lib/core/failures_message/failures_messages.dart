// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../errors/failures.dart';

const String SERVER_FAILURE_MESSAGE = 'please try again later';

const String EMPTY_CACHED_FAILURE_MESSAGE = 'error in cache';

const String FIRE_BASE_EXCEPTION = 'an expected error';
const String FIRE_BASE_AUTH_EXCEPTION = ' invalid email or password';

const String OFFLINE_FAILURE_MESSAGE = 'no internet connection';


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
      return OFFLINE_FAILURE_MESSAGE;
    case FirebaseAuthFailure:
      return FIRE_BASE_AUTH_EXCEPTION;
    default:
      return 'Unexpected Error';
  }
}