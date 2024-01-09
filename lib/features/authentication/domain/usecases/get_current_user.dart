import 'package:dartz/dartz.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/features_repository.dart';

class GetCurrentUser {
  final AuthRepository authRepository;

  GetCurrentUser({required this.authRepository});

  Future<Either<Failure, CurrentUser>> call({required String uid}) async {
    return await authRepository.getCurrentUser(uid: uid);
  }
}
