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
  @override
  List<Object?> get props => [];
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
  @override
  List<Object?> get props => [];
}