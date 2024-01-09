part of 'feeds_cubit.dart';

@immutable
abstract class FeedsState {}

class FeedsInitial extends FeedsState {}

class FeedsLoadingState extends FeedsState {}

class FeedsErrorState extends FeedsState {
  final String msg;

  FeedsErrorState({required this.msg});
}

class FeedsSuccessState extends FeedsState {
  final CurrentUser currentUser;

  FeedsSuccessState({required this.currentUser});
}

class GetAllPostsLoadingState extends FeedsState {}

class GetAllPostsErrorState extends FeedsState {}

class GetAllPostsSuccessState extends FeedsState {}

class PostLikeLoadingState extends FeedsState {}

class PostLikeErrorState extends FeedsState {}

class PostLikeSuccessState extends FeedsState {}

class PostDisLikeLoadingState extends FeedsState {}

class PostDisLikeErrorState extends FeedsState {}

class PostDisLikeSuccessState extends FeedsState {}

class AddCommentLoadingState extends FeedsState {}

class AddCommentErrorState extends FeedsState {}

class AddCommentSuccessState extends FeedsState {}

class GetCommentLoadingState extends FeedsState {}

class GetCommentErrorState extends FeedsState {}

class GetCommentSuccessState extends FeedsState {}

class PostCheckLikeLoadingState extends FeedsState {}

class PostCheckLikeSuccessState extends FeedsState {}

class PostCheckLikeErrorState extends FeedsState {}

class PostCheckSavedLoadingState extends FeedsState {}

class PostCheckSavedSuccessState extends FeedsState {}

class PostCheckSavedErrorState extends FeedsState {}

class SavePostSuccessState extends FeedsState {}

class SavePostErrorState extends FeedsState {}

class UnSavePostSuccessState extends FeedsState {}

class UnSavePostErrorState extends FeedsState {}

class DeletePostLoadingState extends FeedsState {}

class DeletePostSuccessState extends FeedsState {}

class DeletePostErrorState extends FeedsState {}






