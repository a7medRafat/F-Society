import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/users_profile_repository.dart';

class CheckFriendUseCase {
  final FriendProfileRepository friendProfileRepository;

  CheckFriendUseCase({required this.friendProfileRepository});

  Future<Either<Failure,DocumentSnapshot<Map<String, dynamic>>>> call({required String friendId}) async {
    return await friendProfileRepository.checkFriendFollow(friendId: friendId);
  }
}
