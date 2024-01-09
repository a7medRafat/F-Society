import 'package:dartz/dartz.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/features_repository.dart';

class AddUserToFireStore {
  final AuthRepository authRepository;

  AddUserToFireStore({required this.authRepository});

  Future<Either<Failure, void>> call({required CurrentUser currentUser}) async {
    return await authRepository.addUserToFireStore(currentUser: currentUser);
  }
}
