import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/collections/collections.dart';
import 'package:fsociety/core/utiles/strings.dart';
import 'package:fsociety/features/profile/domain/usecases/upload_profile_img.dart';
import 'package:fsociety/features/usersprofile/data/models/followers_model.dart';
import 'package:fsociety/features/usersprofile/data/models/following_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../core/failures_message/failures_messages.dart';
import '../../../core/local_storage/hive_keys.dart';
import '../../../core/local_storage/user_storage.dart';
import '../../../core/shared_preferances/cache_helper.dart';
import '../../layout/cubit/feeds_cubit.dart';
import '../domain/usecases/update_user.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateUserUseCase updateUserUseCase;
  final UploadProfileImgUseCase uploadProfileImgUseCase;

  ProfileCubit({
    required this.updateUserUseCase,
    required this.uploadProfileImgUseCase,
  }) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  void updateUser({required Map<String, dynamic> map}) async {
    emit(EditeProfileLoadingState());
    final failureOrSuccess = await updateUserUseCase.call(map: map);
    failureOrSuccess.fold(
        (failure) => emit(EditProfileErrorState(msg: failureMessage(failure))),
        (success) {
      di.sl<FeedsCubit>().getCurrentUserData();
      emit(EditProfileSuccessState(msg: AppStrings().profileSuccessUpdate));
    });
  }

  void uploadProfileImg() async {
    uploadingState();
    emit(UploadProfileImgLoadingState());
    final failureOrUpload =
        await uploadProfileImgUseCase.call(file: profileImg!);
    failureOrUpload.fold((failure) {
      uploadingState();
      emit(UploadProfileImgErrorState(msg: failureMessage(failure)));
    }, (url) {
      updateUser(map: {'image': url});
      uploadingState();
      emit(UploadProfileImgSuccessState(
          msg: AppStrings().profileImageSuccessUpdate));
    });
  }

  bool uploading = false;

  void uploadingState() {
    uploading = !uploading;
    emit(UploadingChangeState());
  }

  var picker = ImagePicker();
  File? profileImg;

  Future<void> getProfileImg() async {
    emit(PickProfileImageLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImg = File(pickedFile.path);
      profileImgPicked = true;
      emit(ProfilePickedSuccessState());
    } else {
      print('no img selected');

      emit(ProfilePickedErrorState());
    }
  }

  bool gallery = true;

  void changeIndex() {
    gallery = !gallery;
    emit(ChangeIndexState());
  }

  bool profileImgPicked = false;

  void clearProfileImg() {
    profileImg = null;
    profileImgPicked = false;
    emit(ClearProfileImg());
  }

  List<FollowersModel> myFollowers = [];
  List<FollowingModel> myFollowing = [];

  Future<void> getMyFollowers() async {
    Collections().myFollowersCol.snapshots().listen((event) {
      myFollowers = [];
      for (var e in event.docs) {
        myFollowers.add(FollowersModel.fromJson(e.data()));
      }
      // emit(GetMyFollowersSuccessState());
    });
  }

  Future<void> getMyFollowing() async {
    Collections().myFollowingCol.snapshots().listen((event) {
      myFollowing = [];
      for (var e in event.docs) {
        myFollowing.add(FollowingModel.fromJson(e.data()));
      }
      // emit(GetMyFollowingSuccessState());
    });
  }

  List<String> myPosts = [];

  Future<void> getMyPosts() async {
    Collections().postsCol.snapshots().listen((event) {
      myPosts = [];
      for (var e in event.docs) {
        if (e.data()['uid'] == CacheHelper.getData(key: 'uid')) {
          myPosts.add(e.data()['postImage']);
        }
      }
      // emit(GetMyPostsSuccessState());
    });
  }

  List<String> mySaved = [];

  Future<void> getMySaved() async {
    mySaved = [];
    final allPosts = await Collections().postsCol.get();
    for (var e in allPosts.docs) {
      e.reference
          .collection('saved')
          .doc(CacheHelper.getData(key: 'uid'))
          .get()
          .then((value) {
        if (value.data() != null) {
          mySaved.add(value.data()?['savedPost']);
        }
      });

      print(mySaved.length);
      // emit(GetMySavedSuccessState());
    }
  }

  Future<void> getMydData() async {
    emit(GetMyDataLoadingState());
    await getMyFollowers();
    await getMyFollowing();
    await getMySaved();
    await getMyPosts();
    emit(GetMyDataSuccessState());
  }
}
