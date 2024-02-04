import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/all_contacts.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/features/authentication/presentation/screens/login_screen/login_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'app/bloc_observer.dart';
import 'app/myapp.dart';
import 'core/notification/local.dart';
import 'core/shared_preferances/cache_helper.dart';
import 'features/authentication/data/models/current_user_model.dart';
import 'features/layout/presentation/screens/App_Layout.dart';
import 'core/firebase/firebase_options.dart';
import 'features/messages/data/models/get_all_users.dart';
import 'app/injuctoin_container.dart' as di;
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(CurrentUserAdapter());
  Hive.registerAdapter(AllUsersModelAdapter());
  await UserStorage().init();
  await AllContactsImpl().init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await di.init();
  LocalNotifications.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final Widget widget;

  if (CacheHelper.getData(key: 'uid') == null) {
    widget = LoginScreen();
  } else {
    widget = const AppLayout();
  }

  runApp(MyApp(startWidget: widget));
}
