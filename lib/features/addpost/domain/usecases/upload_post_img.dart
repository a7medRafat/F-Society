import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/addpost/domain/repositories/add_post_repository.dart';

import '../../../../core/errors/failures.dart';

class UploadPostImgUseCase {
  final AddPostRepository addPostRepository;

  UploadPostImgUseCase({required this.addPostRepository});

  Future<Either<Failure, String>> call({required File file}) async {
    return addPostRepository.uploadPostImg(file: file);
  }
}
