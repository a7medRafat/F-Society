import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/mysnackbar/mysnackbar.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/core/utiles/strings.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import '../../../../core/local_storage/user_storage.dart';
import '../widgets/background.dart';
import '../../cubit/feeds_cubit.dart';
import '../widgets/feeds/Feed_text_widget.dart';
import '../widgets/feeds/header_widget.dart';
import '../widgets/posts/posts_list.dart';
import '../../../stories/presentation/widgets/story/stories_widget.dart';
import 'package:fsociety/injuctoin_container.dart' as di;
import '../widgets/verify_email_widget.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({super.key});

  final bool isVerified = true;

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FeedsBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: BlocConsumer<FeedsCubit, FeedsState>(
                  listener: (context, state) {
                    if (state is AddCommentSuccessState) {
                      MySnackBar().snackBarMessage(
                          context, AppStrings().successComment);
                    }
                    if (state is SavePostSuccessState) {
                      MySnackBar()
                          .snackBarMessage(context, AppStrings().successSaved);
                    }
                    if (state is DeletePostSuccessState) {
                      MySnackBar()
                          .snackBarMessage(context, AppStrings().deletePost);
                    }
                    if (state is GetAllPostsErrorState) {
                      MySnackBar().snackBarMessage(context, 'error');
                    }
                  },
                  builder: (context, state) {
                    if (state is FeedsErrorState) {
                      return MySnackBar().snackBarMessage(context, state.msg);
                    } else if (di.sl<FeedsCubit>().posts.isEmpty) {
                      return LoadingWidget();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeaderWidget(),
                          if (di
                                  .sl<UserStorage>()
                                  .getData(id: HiveKeys.currentUser)!
                                  .isEmailVerified ==
                              false)
                            VerifyEmailWidget(),
                          const FeedsTextWidget(),
                          const StoriesWidget(),
                          PostsList(
                            commentController: commentController,
                            state: state,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _refresh(context) async {
  di.sl<FeedsCubit>().getAllPosts();
  di.sl<FeedsCubit>().getCurrentUserData();
  di.sl<StoryCubit>().getAllStories();
}
