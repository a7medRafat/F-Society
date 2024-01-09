import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/utiles/strings.dart';
import 'package:fsociety/features/profile/domain/usecases/upload_profile_img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../core/failures_message/failures_messages.dart';
import '../../layout/cubit/feeds_cubit.dart';
import '../domain/usecases/update_user.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

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
      emit(EditProfileSuccessState(msg: AppStrings().profileSuccessUpdate));
      di.sl<FeedsCubit>().getCurrentUserData();
    });
  }

  void uploadProfileImg() async {
    emit(UploadProfileImgLoadingState());
    final failureOrUpload =
        await uploadProfileImgUseCase.call(file: profileImg!);
    failureOrUpload.fold(
        (failure) =>
            emit(UploadProfileImgErrorState(msg: failureMessage(failure))),
        (uil) {
      updateUser(map: {'image': uil});
      print(uil);
      emit(UploadProfileImgSuccessState());
      // updateUser(userModel: userModel);
    });
  }


  var picker = ImagePicker();
  File? profileImg;
  bool profileImgPicked = false;

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

  void clearProfileImg() {
    profileImg = null;
    profileImgPicked = false;
    emit(ClearProfileImg());
  }
}
