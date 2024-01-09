import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/layout/domain/repositories/feeds_repository.dart';
import '../../../../core/errors/failures.dart';

class CheckLikeUseCase {
  final FeedsRepository feedsRepository;

  CheckLikeUseCase({required this.feedsRepository});

  Future<Either<Failure, DocumentSnapshot<Map<String, dynamic>>>> call(String postId) async {
    return await feedsRepository.checkLike(postId);
  }
}
