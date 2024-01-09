import 'package:dartz/dartz.dart';
import 'package:fsociety/features/layout/domain/repositories/feeds_repository.dart';

import '../../../../core/errors/failures.dart';

class UnSavePostUseCase {
  final FeedsRepository feedsRepository;

  UnSavePostUseCase({required this.feedsRepository});

  Future<Either<Failure, void>> call(String postId) async {
    return await feedsRepository.unSavePost(postId);
  }
}
