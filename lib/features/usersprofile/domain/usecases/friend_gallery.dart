import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/users_profile_repository.dart';

class FriendGalleryUseCase{
  final FriendProfileRepository friendProfileRepository;

  FriendGalleryUseCase({required this.friendProfileRepository});

  Future<Either<Failure, List<String>>> call(String friendUid)async{
    return await friendProfileRepository.friendGallery(friendUid);
  }
}