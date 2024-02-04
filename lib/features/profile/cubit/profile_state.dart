part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class EditeProfileLoadingState extends ProfileState {}

class EditProfileSuccessState extends ProfileState {
  final String msg;

  EditProfileSuccessState({required this.msg});
}

class EditProfileErrorState extends ProfileState {
  final String msg;

  EditProfileErrorState({required this.msg});
}

class PickProfileImageLoadingState extends ProfileState {}

class ProfilePickedErrorState extends ProfileState {}

class ProfilePickedSuccessState extends ProfileState {}

class UploadProfileImgLoadingState extends ProfileState {}

class UploadProfileImgSuccessState extends ProfileState {
  final String msg;

  UploadProfileImgSuccessState({required this.msg});
}

class UploadProfileImgErrorState extends ProfileState {
  final String msg;

  UploadProfileImgErrorState({required this.msg});
}



class ChangeIndexState extends ProfileState {}

class ClearProfileImg extends ProfileState {}

class UploadingChangeState extends ProfileState {}

class GetMyFollowersSuccessState extends ProfileState {}
class GetMyFollowersErrorState extends ProfileState {}

class GetMyFollowingSuccessState extends ProfileState {}
class GetMyFollowingErrorState extends ProfileState {}

class GetMyPostsSuccessState extends ProfileState {}
class GetMyPostsLoadingState extends ProfileState {}

class GetMyDataLoadingState extends ProfileState {}
class GetMyDataSuccessState extends ProfileState {}
class GetMySavedSuccessState extends ProfileState {}
