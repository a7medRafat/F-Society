import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../core/errors/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> uploadProfileImg({required File file});

  Future<Either<Failure, Unit>> updateUser({required Map<String, dynamic> map});
}
