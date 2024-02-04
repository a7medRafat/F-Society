import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/collections/collections.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/favourites/presentation/widgets/notification_item.dart';
import 'package:fsociety/features/favourites/presentation/widgets/notifications_text_widget.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import 'package:fsociety/features/favourites/data/models/notification_model.dart';
import '../../../messages/presentation/widgets/message/messsages_background.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key});

  final Stream<QuerySnapshot> notificationsStream = Collections()
      .users
      .doc(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid)
      .collection('notifications')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return MessageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar().appBar(context: context),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NotificationsTextWidget(),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream: notificationsStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingWidget();
                            }
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  PostModel model = PostModel(
                                      postImg: ' ',
                                      name: data['title'],
                                      dateTime: '',
                                      uid: data['senderUid'],
                                      bio: data['bio'],
                                      image: data['image'],
                                      deviceToken: data['fcmToken']);

                                  NotificationModel noti = NotificationModel(
                                    title: data['title'],
                                    body: data['body'],
                                    bio: data['bio'],
                                    senderUid: data['senderUid'],
                                    image: data['image'],
                                    receiverUid: data['receiverUid'],
                                    postId: data['postId'], type: data['type'],
                                    fcmToken: data['fcmToken'],
                                  );
                                  return NotificationItem(
                                      model: model, notificationModel: noti);
                                },
                                itemCount: snapshot.data!.docs.length);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
