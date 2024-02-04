import 'package:dartz/dartz.dart';
import 'package:fsociety/features/usersprofile/data/models/following_model.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/users_profile_repository.dart';

class GetFriendFollowingUseCase{
  final FriendProfileRepository friendProfileRepository;

  GetFriendFollowingUseCase({required this.friendProfileRepository});

  Future<Either<Failure,List<FollowingModel>>> call(String friendUid)async{
    return await friendProfileRepository.getFriendFollowing(friendUid: friendUid);
  }
}