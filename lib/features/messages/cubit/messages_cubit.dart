import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/collections/collections.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/data/models/last_message_model.dart';
import 'package:fsociety/features/messages/data/models/message_model.dart';
import 'package:fsociety/features/messages/domain/usecases/get_messages.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../domain/usecases/get_all_users.dart';
import '../domain/usecases/send_message.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;

  MessagesCubit({
    required this.getAllUsersUseCase,
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
  }) : super(MessagesInitial());

  static MessagesCubit get(context) => BlocProvider.of(context);

  TextEditingController? searchController = TextEditingController();

  List<AllUsersModel> allUsers = [];

  void getUsers() async {
    if (allUsers.isEmpty) {
      emit(GetAllUsersLoadingState());
      final failureOrSuccess = await getAllUsersUseCase.call();
      failureOrSuccess.fold((failure) => emit(GetAllUsersErrorState()),
          (success) {
        allUsers = success;
        emit(GetAllUsersSuccessState(users: success));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String content,
    required LastMsgModel lastMsgModel,
  }) async {
    final failureOrMessage =
        await sendMessageUseCase.call(receiverId, content, lastMsgModel);
    failureOrMessage.fold((failure) => emit(SendMessageErrorState()),
        (message) => emit(SendMessageSuccessState()));
  }




  Future<void> getMessages({required String receiverId}) async {

     Collections()
        .chatCol
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
       List<MessageModel> messages = [];
        for (var e in event.docs) {
          messages.add(MessageModel.fromJson(e.data()));
        }
      emit(GetMessagesSuccessState(list: messages));
    });
  }
}
