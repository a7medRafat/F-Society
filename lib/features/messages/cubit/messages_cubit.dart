import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/data/models/message_model.dart';
import 'package:fsociety/injuctoin_container.dart' as di;
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  static MessagesCubit get(context) => BlocProvider.of(context);

  GetAllUsersModel? allUsersModel;
  List<GetAllUsersModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      emit(GetAllUsersLoadingState());

      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uid'] != di.sl<FeedsCubit>().itsUser!.uid){
            users.add(GetAllUsersModel.fromJson(element.data()));
          }
        });
        print('users==> ${users.length}');
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUsersErrorState());
      });
    }
  }

  Future<void> sendMessage(
      {required String receiverId,
      required String dateTime,
      required String content}) async {
    emit(SendMessageLoadingState());
    MessageModel messageModel = MessageModel(
        dateTime: dateTime,
        senderId: di.sl<FeedsCubit>().itsUser!.name,
        receiverId: receiverId,
        content: content);

    FirebaseFirestore.instance
        .collection('users')
        .doc(di.sl<FeedsCubit>().itsUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(di.sl<FeedsCubit>().itsUser!.uid)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  Future<void> getMessages({required String receiverId}) async {

    FirebaseFirestore.instance
        .collection('users')
        .doc(di.sl<FeedsCubit>().itsUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }
}
