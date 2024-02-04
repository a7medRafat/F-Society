import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/core/notification/local.dart';
import 'package:fsociety/features/favourites/presentation/screens/fav.dart';
import 'package:fsociety/features/messages/presentation/screens/messages.dart';
import 'package:fsociety/features/profile/presentation/screens/profile.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class FcmMessaging {
  Future<void> backgroundMessage(RemoteMessage remoteMessage) async {
    print(remoteMessage.notification!.body);
  }

  onBackGroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(backgroundMessage);
  }

  onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: '');

      print('--------------------');

      print(message.data['uid']);
      if (message.notification != null) {}
    });
  }

  onMessageOpenedApp(context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('============================');
      if (message.data['type'] == "follow") {
        Navigation().navigateTo(context, FavouritesScreen());
      } else {
        Navigation().navigateTo(context, Messages());
      }
    });
  }

  initialMessage(context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      initialMessage.data['type'] == "follow"
          ? Navigation().navigateTo(context, const Profile())
          : Navigation().navigateTo(context, Messages());
    }
  }
}
