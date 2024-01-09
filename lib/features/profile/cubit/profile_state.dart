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
class UploadProfileImgSuccessState extends ProfileState {}
class UploadProfileImgErrorState extends ProfileState {
  final String msg;

  UploadProfileImgErrorState({required this.msg});
}


class ChangeIndexState extends ProfileState {}
class ClearProfileImg extends ProfileState {}


