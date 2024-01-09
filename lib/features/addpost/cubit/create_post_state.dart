part of 'create_post_cubit.dart';

@immutable
abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoadingState extends CreatePostState {}
class CreatePostErrorState extends CreatePostState {
  final String errorMsg;

  CreatePostErrorState({required this.errorMsg});
}
class CreatePostSuccessState extends CreatePostState {}

class UploadPostImgLoadingState extends CreatePostState {}
class UploadPostImgSuccessState extends CreatePostState {}
class UploadPostImgErrorState extends CreatePostState {}

class PostImagePickedLoadingState extends CreatePostState {}
class PostImagePickedSuccessState extends CreatePostState {}
class PostImagePickedErrorState extends CreatePostState {}

class PostImageRemoveState extends CreatePostState {}
class ClearPostImgState extends CreatePostState {}

