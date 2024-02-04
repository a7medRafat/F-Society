import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/mysnackbar/mysnackbar.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/core/utiles/loading_dialog.dart';
import 'package:fsociety/core/utiles/strings.dart';
import 'package:fsociety/features/addpost/cubit/create_post_cubit.dart';
import 'package:fsociety/features/addpost/presentation/widgets/add_post_header.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/layout/presentation/screens/App_Layout.dart';
import 'package:fsociety/features/layout/presentation/widgets/background.dart';
import '../../../../core/navigation/navigation.dart';
import '../widgets/create_post_widget.dart';
import '../widgets/default_img.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedsBackground(
        child: Scaffold(
      appBar: MyAppBar().appBar(
          textColor: Colors.deepPurple,
          context: context,
          fun: () {
            if (di.sl<CreatePostCubit>().postImg != null) {
              showLoadingDialog(context, 'loading');
              di.sl<CreatePostCubit>().uploadPostImg();
            }
          },
          text: 'Post'),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<FeedsCubit, FeedsState>(
          listener: (context, state) {
            if (state is GetAllPostsSuccessState) {
              MySnackBar().snackBarMessage(context, AppStrings().addPost);
              hideLoadingDialog(context);
              di.sl<CreatePostCubit>().clearPostImg();
              Navigation().navigateAndFinish(context, const AppLayout());
            }
          },
          child: BlocConsumer<CreatePostCubit, CreatePostState>(
            listener: (context, state) {
              if (state is UploadPostImgErrorState) {
                hideLoadingDialog(context);
                MySnackBar().snackBarMessage(context, 'try again later');
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const AddPostHeader(),
                  const SizedBox(height: 20),
                  di.sl<CreatePostCubit>().postImgPicked == true
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
