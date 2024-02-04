import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/data/models/last_message_model.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../../core/utiles/app_bar.dart';
import '../widgets/message_search_detail/message_detail_footer.dart';
import '../widgets/message_search_detail/message_detail_header.dart';
import '../widgets/message_search_detail/message_details_background.dart';
import '../widgets/message_search_detail/messages_content_widget.dart';

class SearchMessageDetailScreen extends StatelessWidget {
  final AllUsersModel model;

  SearchMessageDetailScreen({super.key, required this.model});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<MessagesCubit, MessagesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(slivers: [
                    MyAppBar().sliverBar(
                        context: context,
                        height: 0.36,
                        backGround: MessageDetailBackground(
                            child: SearchMessageDetailHeader(model: model))),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [  MessageContentWidget(receiverId: model.uid!)],
                      ),
                    )
                  ]),
                ),
                MessageDetailFooter(
                  sendMessage: () {
                    LastMsgModel last = LastMsgModel(
                        name: model.name,
                        image: model.image,
                        lastMessage: messageController.text,
                        receiverId: model.uid);

                    if (messageController.text.isNotEmpty) {
                      di.sl<MessagesCubit>().sendMessage(
                            receiverId: model.uid!,
                            content: messageController.text,
                            lastMsgModel: last,
                          );
                    }
                    messageController.clear();
                  },
                  messageController: messageController,
                ),
              ],
            );
          },
        ));
  }
}
