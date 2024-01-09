import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/mysnackbar/mysnackbar.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import '../widget/edit_profile/done_widget.dart';
import '../widget/edit_profile/edite_input_widget.dart';
import '../widget/edit_profile/img_picker.dart';
import '../widget/edit_profile/edite_profile_background.dart';
import '../widget/profile_img_widget.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> fKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text =
        di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!;
    bioController.text =
        di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.bio!;
    phoneController.text =
        di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.phone!;

    return EditProfileBackground(
        child: Scaffold(
            appBar: MyAppBar().appBar(
                text: 'Update',
                context: context,
                fun: () => di.sl<ProfileCubit>().updateUser(map: {
                      'name': nameController.text,
                      'phone': phoneController.text,
                      'bio': bioController.text,
                    }),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is UploadProfileImgErrorState) {
                      MySnackBar().snackBarMessage(context, state.msg);
                      di.sl<ProfileCubit>().clearProfileImg();
                    }
                    if (state is EditProfileSuccessState) {
                      MySnackBar().snackBarMessage(context, state.msg);
                      di.sl<ProfileCubit>().profileImgPicked = false;
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (state is EditeProfileLoadingState ||
                            state is UploadProfileImgLoadingState)
                          const LinearProgressIndicator(),
                        ProfileImgWidget(
                          img: di.sl<ProfileCubit>().profileImg == null
                              ? NetworkImage(di
                                  .sl<UserStorage>()
                                  .getData(id: HiveKeys.currentUser)!
                                  .image!)
                              : FileImage(di.sl<ProfileCubit>().profileImg!)
                                  as ImageProvider,
                        ),
                        di.sl<ProfileCubit>().profileImgPicked == true
                            ? const DoneWidget()
                            : const ImgPiker(),
                        const SizedBox(height: 50),
                        EditeInputWidget(
                          nameCon: nameController,
                          bioCon: bioController,
                          phoneCon: phoneController,
                          profileK: fKey,
                        )
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}
