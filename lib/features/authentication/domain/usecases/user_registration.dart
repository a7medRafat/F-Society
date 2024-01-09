import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fsociety/features/authentication/domain/repositories/features_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/register_model.dart';

class UserRegistrationUseCase {
  final AuthRepository authRepository;

  UserRegistrationUseCase({required this.authRepository});

  Future<Either<Failure, UserCredential>> call({required RegisterBody registerBody})async{
    return await authRepository.userRegistration(registerBody: registerBody);
  }
}
