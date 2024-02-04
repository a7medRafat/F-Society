import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/failures_message/failures_messages.dart';
import '../data/models/story_model.dart';
import '../domain/usecases/create_story_img.dart';
import '../domain/usecases/get_all_stories.dart';
import '../domain/usecases/upload_story_img.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  final UploadStoryImgUseCase uploadStoryImgUseCase;
  final CreateStoryImgUseCase createStoryImgUseCase;
  final GetAllStoriesUseCase getAllStoriesUseCase;

  StoryCubit(
      {required this.uploadStoryImgUseCase,
      required this.createStoryImgUseCase,
      required this.getAllStoriesUseCase})
      : super(StoryInitial());

  var picker = ImagePicker();
  File? storyImg;

  Future<void> getStoryImg() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      storyImg = File(pickedFile.path);
      emit(StoryImgPickedSuccessState());
    } else {
      emit(StoryImgPickedErrorState());
    }
  }

  Future<void> uploadStoryImg() async {
    DateTime expiryDate = DateTime.now().add(const Duration(hours: 24));
    final failureOrUpload = await uploadStoryImgUseCase.call(file: storyImg!);
    failureOrUpload.fold((failure) => emit(UploadStoryImgErrorState()),
        (downloadUrl) {
      StoryModel storyModel = StoryModel(
          storyImage: downloadUrl,
          image: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image,
          userId: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid,
          name: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name,
          date: DateTime.now().toString(),
          expiryDate: expiryDate.toString());
      createStoryImg(storyModel: storyModel);
      emit(UploadStoryImgSuccessState());
    });
  }

  void createStoryImg({required StoryModel storyModel}) async {
    emit(CreateStoryImgLoadingState());
    final failureOrCreate = await createStoryImgUseCase.call(storyModel);
    failureOrCreate.fold(
      (failure) =>
          emit(CreateStoryImgErrorState(errorMsg: failureMessage(failure))),
      (success) async{
        await getAllStories();
        emit(CreateStoryImgSuccessState());
      },
    );
  }

  List<StoryModel> validStories = [];
  List<StoryModel> invalidStories = [];

  Future<void> getAllStories() async {
    validStories = [];
    invalidStories = [];
    final failureOrStories = await getAllStoriesUseCase.call();
    failureOrStories.fold((failure) => emit(GetAllStoriesErrorState()),
        (stories) {
      for (var e in stories.docs) {
        DateTime expirationTime = DateTime.parse(e.data()['expiryDate']);
        if (DateTime.now().isBefore(expirationTime)) {
          validStories.add(StoryModel.fromJson(e.data()));
        } else {
          invalidStories.add(StoryModel.fromJson(e.data()));
        }
      }
      print('valllid===? ${validStories.length}');
      emit(GetAllStoriesSuccessState());
    });
  }

}
