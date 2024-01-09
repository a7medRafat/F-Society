import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fsociety/features/authentication/domain/repositories/features_repository.dart';

import '../../../../core/errors/failures.dart';

class UserLoginUseCase {
  final AuthRepository authRepository;

  UserLoginUseCase({required this.authRepository});

  Future<Either<Failure, UserCredential>> call(email, password) async {
    return await authRepository.userLogin(email: email, password: password);
  }

}