import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/addpost/domain/repositories/add_post_repository.dart';

import '../../../../core/errors/failures.dart';

class CreatePostImgUseCase {
  final AddPostRepository addPostRepository;

  CreatePostImgUseCase({required this.addPostRepository});

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(PostModel postModel) async {
    return addPostRepository.createPostImg(postModel: postModel);
  }
}
