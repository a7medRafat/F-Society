import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';
import 'package:fsociety/features/messages/data/models/last_message_model.dart';
import 'package:fsociety/features/messages/presentation/widgets/message_detail/message_detail_header.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../../core/utiles/app_bar.dart';
import '../widgets/message_search_detail/message_detail_footer.dart';
import '../widgets/message_search_detail/message_details_background.dart';
import '../widgets/message_search_detail/messages_content_widget.dart';

class MessageDetailScreen extends StatelessWidget {
  final LastMsgModel model;

  MessageDetailScreen({super.key, required this.model});

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
                            child: MessageDetailHeader(model: model))),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [ MessageContentWidget(receiverId: model.receiverId!)],
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
                        receiverId: model.receiverId);

                    if (messageController.text.isNotEmpty) {
                      di.sl<MessagesCubit>().sendMessage(
                            receiverId: model.receiverId!,
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
