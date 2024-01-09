import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/register_model.dart';

abstract class AuthRepository {

  Future<Either<Failure, UserCredential>> userRegistration({required RegisterBody registerBody});

  Future<Either<Failure, UserCredential>> userLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, CurrentUser>> getCurrentUser({required String uid});

  Future<Either<Failure, void>> addUserToFireStore({required CurrentUser currentUser});
}
