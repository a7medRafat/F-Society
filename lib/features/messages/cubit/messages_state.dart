part of 'messages_cubit.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();
}

class MessagesInitial extends MessagesState {
  @override
  List<Object> get props => [];
}


class GetAllUsersLoadingState extends MessagesState{
  @override
  List<Object?> get props => [];
}
class GetAllUsersSuccessState extends MessagesState{
  final List<AllUsersModel> users;

  const GetAllUsersSuccessState({required this.users});
  @override
  List<Object?> get props => [users];
}
class GetAllUsersErrorState extends MessagesState{
  @override
  List<Object?> get props => [];
}


class SendMessageLoadingState extends MessagesState{
  @override
  List<Object?> get props => [];
}
class SendMessageSuccessState extends MessagesState{
  @override
  List<Object?> get props => [];
}
class SendMessageErrorState extends MessagesState{
  @override
  List<Object?> get props => [];
}

class GetMessagesLoadingState extends MessagesState{
  @override
  List<Object?> get props => [];
}
class GetMessagesSuccessState extends MessagesState{

  final List<MessageModel> list;

  const GetMessagesSuccessState({required this.list});
  @override
  List<Object?> get props => list;
}
class GetMessagesErrorState extends MessagesState{
  @override
  List<Object?> get props => [];
}
