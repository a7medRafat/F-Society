import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/failures_message/failures_messages.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/addpost/domain/usecases/create_post_img.dart';
import 'package:fsociety/features/addpost/domain/usecases/upload_post_img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../layout/cubit/feeds_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import 'package:intl/intl.dart';
import '../data/models/post_model.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit(
      {required this.uploadPostImgUseCase, required this.createPostImgUseCase})
      : super(CreatePostInitial());
  final UploadPostImgUseCase uploadPostImgUseCase;
  final CreatePostImgUseCase createPostImgUseCase;

  static CreatePostCubit get(context) => BlocProvider.of(context);

  void uploadPostImg() async {
    final failureOrUpload = await uploadPostImgUseCase.call(file: postImg!);
    failureOrUpload.fold((failure) => emit(UploadPostImgErrorState()),
            (downLoadUrl) {
          PostModel postModel = PostModel(
              postImg: downLoadUrl,
              name: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!
                  .name!,
              dateTime: DateFormat('kk:mm:a').format(DateTime.now()).toString(),
              uid: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid,
              bio: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.bio,
              image: di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image!,
              deviceToken: CacheHelper.getData(key: 'DEVICE_TOKEN'));

          createPostImg(postModel: postModel);
          emit(UploadPostImgSuccessState());
        });
  }

  void createPostImg({required PostModel postModel}) async {
    emit(CreatePostLoadingState());
    final failureOrCreate = await createPostImgUseCase.call(postModel);
    failureOrCreate.fold(
          (failure) =>
          emit(CreatePostErrorState(errorMsg: failureMessage(failure))),
          (success) {
            di.sl<FeedsCubit>().getAllPosts();
        emit(CreatePostSuccessState());
      },
    );
  }

  var picker = ImagePicker();
  File? postImg;
  bool postImgPicked = false;

  Future<void> getPostImg() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImg = File(pickedFile.path);
      postImgPicked = true;
      emit(PostImagePickedSuccessState());
    } else {
      print('no img selected');
      emit(PostImagePickedErrorState());
    }
  }



  void clearPostImg() {
    postImgPicked = false;
    postImg = null;
    emit(ClearPostImgState());
  }
}
