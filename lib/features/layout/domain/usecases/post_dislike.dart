import 'package:dartz/dartz.dart';
import 'package:fsociety/features/layout/domain/repositories/feeds_repository.dart';

import '../../../../core/errors/failures.dart';

class DisLikeUseCase{
  final FeedsRepository feedsRepository;

  DisLikeUseCase({required this.feedsRepository});
  Future<Either<Failure,void>> call(postId)async{
    return await feedsRepository.disLike(postId);
  }
}