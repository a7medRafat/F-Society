import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/static_search_widhet.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import 'package:fsociety/features/messages/presentation/widgets/message/message_item.dart';
import '../../data/models/last_message_model.dart';
import '../widgets/message/message_txt_widget.dart';
import '../widgets/message/messsages_background.dart';

class Messages extends StatelessWidget {
  Messages({super.key});

  final Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance
      .collection('users')
      .doc(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.uid)
      .collection('chats')
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
                  const MessageTextWidget(),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const StaticSearchWidget(),
                        const SizedBox(height: 20),
                        StreamBuilder(
                          stream: chatStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading");
                            }
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  LastMsgModel last = LastMsgModel(
                                      name: data['name'],
                                      image: data['image'],
                                      lastMessage: data['lastMessage'],
                                      receiverId: data['receiverId']);
                                  return MessageItem(
                                    model: last,
                                  );
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
