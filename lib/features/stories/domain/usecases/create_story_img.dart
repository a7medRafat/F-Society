import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/stories_repository.dart';

class CreateStoryImgUseCase {
  final StoriesRepository storiesRepository;

  CreateStoryImgUseCase({required this.storiesRepository});

  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>> call(StoryModel storyModel) async {
    return storiesRepository.createStoryImg(storyModel: storyModel);
  }
}
