import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/layout/data/models/comment_model.dart';
import 'package:fsociety/features/layout/domain/repositories/feeds_repository.dart';

import '../../../../core/errors/failures.dart';

class AddCommentUseCase {
  final FeedsRepository feedsRepository;

  AddCommentUseCase({required this.feedsRepository});

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(
      String postId, CommentModel model) async {
    return await feedsRepository.addComment(postId, model);
  }
}
