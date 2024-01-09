import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/layout/domain/repositories/feeds_repository.dart';

import '../../../../core/errors/failures.dart';

class GetCommentsUseCase {
  final FeedsRepository feedsRepository;

  GetCommentsUseCase({required this.feedsRepository});

  Future<Either<Failure,QuerySnapshot<Map<String, dynamic>>>> call(
      String postsId) async {
    return await feedsRepository.getComments(postsId);
  }
}
