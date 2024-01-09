import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/injuctoin_container.dart' as di;
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';
import '../../../../layout/cubit/feeds_cubit.dart';

class MessageContentWidget extends StatelessWidget {
  const MessageContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            itemCount: MessagesCubit.get(context).messages.length,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                // according to index, put message to left or right:
                mainAxisAlignment: di.sl<FeedsCubit>().itsUser!.uid ==
                        MessagesCubit.get(context).messages[index].receiverId
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
                      MessagesCubit.get(context).messages[index].content!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
