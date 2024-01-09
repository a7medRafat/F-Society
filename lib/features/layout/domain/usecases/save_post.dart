import 'package:dartz/dartz.dart';
import 'package:fsociety/features/layout/domain/repositories/feeds_repository.dart';

import '../../../../core/errors/failures.dart';

class SavePostUseCase {
  final FeedsRepository feedsRepository;

  SavePostUseCase({required this.feedsRepository});

  Future<Either<Failure, void>> call(String postId,String postImg) async {
    return await feedsRepository.savePost(postId,postImg);
  }
}
