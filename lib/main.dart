import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/features/addpost/cubit/create_post_cubit.dart';
import 'package:fsociety/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:fsociety/features/authentication/presentation/screens/login_screen/login_screen.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'bloc_observer.dart';
import 'config/style/app_theme/app_themes.dart';
import 'core/const/const.dart';
import 'core/shared_preferances/cache_helper.dart';
import 'features/authentication/cubit/register_cubit/register_cubit.dart';
import 'features/authentication/data/models/current_user_model.dart';
import 'features/layout/cubit/feeds_cubit.dart';
import 'features/layout/presentation/screens/App_Layout.dart';
import 'core/firebase/firebase_options.dart';
import 'injuctoin_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(CurrentUserAdapter());
  await UserStorage().init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await di.init();
  uid = CacheHelper.getData(key: 'uid') ?? '';

  final Widget widget;

  if (uid!.isEmpty) {
    widget = LoginScreen();
  } else {
    widget = AppLayout();
  }

  runApp(MyApp(startWidget: widget));
}

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
        BlocProvider.value(value: di.sl<RegisterCubit>()),
        BlocProvider.value(value: di.sl<LoginCubit>()),
        BlocProvider.value(
            value: di.sl<FeedsCubit>()..getAllPosts()..getCurrentUserData()),
        BlocProvider.value(value: di.sl<StoryCubit>()..getAllStories()),
        BlocProvider.value(value: di.sl<ProfileCubit>()),
        BlocProvider.value(value: di.sl<CreatePostCubit>()),
        BlocProvider(create: (context) => MessagesCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: widget.startWidget,
      ),
    );
  }
}
