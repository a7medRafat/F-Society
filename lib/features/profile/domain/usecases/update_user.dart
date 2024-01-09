import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/profile_repository.dart';

class UpdateUserUseCase {
  final ProfileRepository profileRepository;

  UpdateUserUseCase({required this.profileRepository});

  Future<Either<Failure, Unit>> call(
      {required Map<String,dynamic> map}) async {
    return await profileRepository.updateUser(map: map);
  }
}
