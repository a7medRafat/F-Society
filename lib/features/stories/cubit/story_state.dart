part of 'story_cubit.dart';

@immutable
abstract class StoryState {}

class StoryInitial extends StoryState {}

class UploadStoryImgLoadingState extends StoryState {}

class UploadStoryImgErrorState extends StoryState {}

class UploadStoryImgSuccessState extends StoryState {}

class CreateStoryImgLoadingState extends StoryState {}

class CreateStoryImgErrorState extends StoryState {
  final String errorMsg;

  CreateStoryImgErrorState({required this.errorMsg});
}

class CreateStoryImgSuccessState extends StoryState {}

class StoryImgPickedErrorState extends StoryState {}

class StoryImgPickedSuccessState extends StoryState {}

class StoryImgRemovedSuccessState extends StoryState {}

class GetAllStoriesLoadingState extends StoryState {}

class GetAllStoriesErrorState extends StoryState {}

class GetAllStoriesSuccessState extends StoryState {}
