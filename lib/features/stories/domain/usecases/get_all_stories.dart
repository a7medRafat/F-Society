import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/stories_repository.dart';

class GetAllStoriesUseCase {
  final StoriesRepository storiesRepository;

  GetAllStoriesUseCase({required this.storiesRepository});

  Future<Either<Failure, QuerySnapshot<Map<String, dynamic>>>> call() async {
    return storiesRepository.getAllStories();
  }
}
