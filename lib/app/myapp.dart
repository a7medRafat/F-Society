import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/style/app_theme/app_themes.dart';
import '../features/addpost/cubit/create_post_cubit.dart';
import '../features/authentication/cubit/login_cubit/login_cubit.dart';
import '../features/authentication/cubit/register_cubit/register_cubit.dart';
import '../features/favourites/cubit/favourites_cubit.dart';
import '../features/layout/cubit/feeds_cubit.dart';
import '../features/messages/cubit/messages_cubit.dart';
import '../features/profile/cubit/profile_cubit.dart';
import '../features/stories/cubit/story_cubit.dart';
import '../features/usersprofile/cubit/friends_cubit.dart';
import 'injuctoin_container.dart';

class MyApp extends StatefulWidget {


  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  _MyAppState();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<RegisterCubit>()),
        BlocProvider.value(value: sl<LoginCubit>()),
        BlocProvider.value(value: sl<StoryCubit>()..getAllStories()),
        BlocProvider.value(value: sl<FeedsCubit>()..getAllPosts()),
        BlocProvider.value(value: sl<ProfileCubit>()),
        BlocProvider.value(value: sl<CreatePostCubit>()),
        BlocProvider.value(value: sl<MessagesCubit>()..getUsers()),
        BlocProvider.value(value: sl<FriendsCubit>()),
        BlocProvider.value(value: sl<FavouritesCubit>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          home: widget.startWidget),
    );
  }
}
