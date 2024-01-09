import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/layout/presentation/screens/App_Layout.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/utiles/loading_widget.dart';
import '../../cubit/messages_cubit.dart';
import '../widgets/message_item.dart';
import '../widgets/message_txt_widget.dart';
import '../widgets/messsages_background.dart';
import '../widgets/search_widget.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar(context),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MessageTextWidget(),
                    const SizedBox(height: 30),
                    BlocConsumer<MessagesCubit, MessagesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is GetAllUsersLoadingState) {
                          return LoadingWidget();
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SearchWidget(),
                                const SizedBox(height: 20),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => MessageItem(
                                    message: 'hallow',
                                    model:
                                        MessagesCubit.get(context).users[index],
                                  ),
                                  itemCount:
                                      MessagesCubit.get(context).users.length,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  _appBar(context) => AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigation().navigateTo(context, AppLayout());
            },
            icon: Icon(Icons.arrow_back)),
      );
}
