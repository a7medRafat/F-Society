import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/mysnackbar/mysnackbar.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import '../profile_background.dart';
import '../widget/edit_profile/edite_input_widget.dart';
import '../widget/edit_profile/img_picker.dart';
import '../widget/profile_img_widget.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

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

    return ScaffoldMessenger(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          MyAppBar().sliverBar(
              textColor: Colors.deepPurple,
              context: context,
              actionText: 'Update',
              actionFun: () => di.sl<ProfileCubit>().uploading
                  ? null
                  : di.sl<ProfileCubit>().updateUser(map: {
                      'name': nameController.text,
                      'phone': phoneController.text,
                      'bio': bioController.text,
                    }),
              height: 0.65,
              backGround: ProfileBackground(
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is UploadProfileImgErrorState) {
                    MySnackBar().snackBarMessage(context, state.msg);
                  }
                  if (state is UploadProfileImgSuccessState) {
                    MySnackBar().snackBarMessage(context, state.msg);
                  }
                  if (state is EditProfileErrorState) {
                    MySnackBar().snackBarMessage(context, state.msg);
                  }
                  if (state is EditProfileSuccessState) {
                    MySnackBar().snackBarMessage(context, state.msg);
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is EditeProfileLoadingState)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: LinearProgressIndicator(),
                        ),
                      ProfileImgWidget(
                        img: di.sl<ProfileCubit>().profileImg == null
                            ? NetworkImage(di
                                .sl<UserStorage>()
                                .getData(id: HiveKeys.currentUser)!
                                .image!)
                            : FileImage(di.sl<ProfileCubit>().profileImg!)
                                as ImageProvider,
                      ),
                      const ImgPikerOrDone(),
                    ],
                  );
                },
              ))),
          SliverList(
              delegate: SliverChildListDelegate([
            EditeInputWidget(
              nameCon: nameController,
              bioCon: bioController,
              phoneCon: phoneController,
              profileK: fKey,
            )
          ]))
        ],
      )),
    );
  }
}
