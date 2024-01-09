import 'package:dartz/dartz.dart';
import 'package:fsociety/features/layout/domain/repositories/feeds_repository.dart';

import '../../../../core/errors/failures.dart';

class PostLikeUseCase{
  final FeedsRepository feedsRepository;

  PostLikeUseCase({required this.feedsRepository});
  Future<Either<Failure,void>> call(String postId)async{
    return await feedsRepository.postLike(postId);
  }
}