import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fsociety/features/authentication/domain/repositories/features_repository.dart';

import '../../../../core/errors/failures.dart';

class GoogleSignInUseCase {
  final AuthRepository authRepository;

  GoogleSignInUseCase({required this.authRepository});

  Future<Either<Failure, UserCredential>> call() async {
    return await authRepository.googleSignIn();
  }

}