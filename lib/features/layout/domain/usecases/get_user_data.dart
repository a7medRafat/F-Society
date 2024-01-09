import 'package:dartz/dartz.dart';
import 'package:fsociety/features/authentication/data/models/current_user_model.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/feeds_repository.dart';

class GetUserDataUseCase {
  final FeedsRepository feedsRepository;

  GetUserDataUseCase({required this.feedsRepository});

  Future<Either<Failure, CurrentUser>> call() async {
    return await feedsRepository.getCurrentUserData();
  }
}
