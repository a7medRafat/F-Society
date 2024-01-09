import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/presentation/widgets/message_detail/message_detail_footer.dart';
import 'package:fsociety/features/messages/presentation/widgets/message_detail/message_detail_header.dart';
import 'package:fsociety/features/messages/presentation/widgets/message_detail/messages_content_widget.dart';
import 'package:fsociety/features/messages/presentation/widgets/message_details_background.dart';

import '../../../../core/utiles/loading_widget.dart';

class MessageDetailScreen extends StatelessWidget {
  final GetAllUsersModel model;

  MessageDetailScreen({super.key, required this.model});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MessageDetailBackground(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: BlocConsumer<MessagesCubit, MessagesState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  if(state is GetMessagesLoadingState)
                    LoadingWidget(),
                  MessageDetailHeader(model: model),
                  const MessageContentWidget(),
                  MessageDetailFooter(
                    sendMessage: () {
                      if (messageController.text.isNotEmpty) {
                        MessagesCubit.get(context).sendMessage(
                            receiverId: model.uid!,
                            dateTime: DateTime.now().toString(),
                            content: messageController.text).then((value) {
                          messageController.clear();
                        });
                      }
                    },
                    messageController: messageController,
                  )
                ],
              );
            },
          )),
    );
  }
}
