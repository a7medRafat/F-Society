import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';

class MessageContentWidget extends StatefulWidget {
  const MessageContentWidget({super.key, required this.receiverId});

  final String receiverId;

  @override
  State<MessageContentWidget> createState() => _MessageContentWidgetState();
}

class _MessageContentWidgetState extends State<MessageContentWidget> {
  @override
  void initState() {
    di.sl<MessagesCubit>().getMessages(receiverId: widget.receiverId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current is GetMessagesSuccessState,
      builder: (context, state) {
        if (state is GetMessagesSuccessState) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.list.length,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                // according to index, put message to left or right:
                mainAxisAlignment: di
                            .sl<UserStorage>()
                            .getData(id: HiveKeys.currentUser)!
                            .uid ==
                        state.list[index].receiverId
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: size.width * 0.80),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(20.0),
                        bottomRight: const Radius.circular(20.0),
                        topLeft: index.isEven
                            ? Radius.zero
                            : const Radius.circular(20.0),
                        topRight: index.isOdd
                            ? Radius.zero
                            : const Radius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      state.list[index].content!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              );
            },
          );
        }
        // ignore: prefer_const_constructors
        return LoadingWidget();
      },
    );
  }
}
