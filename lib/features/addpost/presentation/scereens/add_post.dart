import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/mysnackbar/mysnackbar.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/core/utiles/loading_dialog.dart';
import 'package:fsociety/features/addpost/cubit/create_post_cubit.dart';
import 'package:fsociety/features/addpost/presentation/widgets/add_post_header.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/layout/presentation/widgets/background.dart';
import 'package:fsociety/features/layout/presentation/screens/App_Layout.dart';
import '../../../../core/navigation/navigation.dart';
import '../widgets/create_post_widget.dart';
import '../widgets/default_img.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return FeedsBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar().appBar(
          text: 'post',
          context: context,
          fun: () {
            if (di.sl<CreatePostCubit>().postImg == null) {
              null;
            } else {
              di.sl<CreatePostCubit>().uploadPostImg();
              isLoading = true;
              showLoadingDialog(context, 'loading');
            }
          }),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<FeedsCubit, FeedsState>(
          listener: (context, state) {
            if (state is GetAllPostsSuccessState) {
              hideLoadingDialog(context);
              Navigation().navigateAndFinish(context, AppLayout());
              di.sl<CreatePostCubit>().postImgPicked = false;
            }
            },
          child: BlocConsumer<CreatePostCubit, CreatePostState>(
            listener: (context, state) {
               if (state is UploadPostImgErrorState) {
              hideLoadingDialog(context);
              MySnackBar().snackBarMessage(context, 'try again later');
              }
               if (state is CreatePostSuccessState) {
              MySnackBar().snackBarMessage(context, 'create post successfully');
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const AddPostHeader(),
                  const SizedBox(height: 40),
                  di.sl<CreatePostCubit>().postImgPicked  == true
                      ? CreatePostWidget(
                          img: FileImage(di.sl<CreatePostCubit>().postImg!),
                        )
                      : const dafaultImg(),
                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}
