import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/stories_repository.dart';

class UploadStoryImgUseCase {
  final StoriesRepository storiesRepository;

  UploadStoryImgUseCase({required this.storiesRepository});

  Future<Either<Failure, String>> call({required File file}) async {
    return storiesRepository.uploadStoryImg(file: file);
  }
}
