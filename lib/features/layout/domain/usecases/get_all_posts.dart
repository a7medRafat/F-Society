import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/feeds_repository.dart';

class GetAllPostsUseCase {
  final FeedsRepository feedsRepository;

  GetAllPostsUseCase({required this.feedsRepository});

  Future<Either<Failure,QuerySnapshot<Map<String, dynamic>>>> call() async {
    return await feedsRepository.getAllPosts();
  }
}
