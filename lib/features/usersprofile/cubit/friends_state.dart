part of 'friends_cubit.dart';

@immutable
abstract class FriendsState {}

class FriendsInitial extends FriendsState {}

class FriendGalleyLoadingState extends FriendsState {}
class FriendGalleyErrorState extends FriendsState {}
class FriendGalleySuccessState extends FriendsState {}


class SendFollowLoadingState extends FriendsState {}
class SendFollowErrorState extends FriendsState {}
class SendFollowSuccessState extends FriendsState {}

class UnFollowLoadingState extends FriendsState {}
class UnFollowErrorState extends FriendsState {}
class UnFollowSuccessState extends FriendsState {}

class GetFriendFollowersLoadingState extends FriendsState {}
class GetFriendFollowersErrorState extends FriendsState {}
class GetFriendFollowersSuccessState extends FriendsState {}

class GetFriendFollowingLoadingState extends FriendsState {}
class GetFriendFollowingErrorState extends FriendsState {}
class GetFriendFollowingSuccessState extends FriendsState {}

class CheckingFollowLoadingState extends FriendsState {}
class CheckingFollowErrorState extends FriendsState {}
class CheckingFollowSuccessState extends FriendsState {}

class CheckIsFollowLoadingState extends FriendsState {}
class CheckIsFollowErrorState extends FriendsState {}
class CheckIsFollowSuccessState extends FriendsState {}

class TappedSuccessState extends FriendsState {}

class GetFriendDataLoadingState extends FriendsState {}
class GetFriendDataSuccessState extends FriendsState {}
