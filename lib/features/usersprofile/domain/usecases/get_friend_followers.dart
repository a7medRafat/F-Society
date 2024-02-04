import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/followers_model.dart';
import '../repositories/users_profile_repository.dart';

class GetFriendFollowersUseCase{
  final FriendProfileRepository friendProfileRepository;

  GetFriendFollowersUseCase({required this.friendProfileRepository});

  Future<Either<Failure,List<FollowersModel>>> call(String friendUid)async{
    return await friendProfileRepository.getFriendFollowers(friendUid: friendUid);
  }
}