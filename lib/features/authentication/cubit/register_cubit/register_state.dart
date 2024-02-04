import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String msg;

  RegisterErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class RegisterSuccessState extends RegisterState {
  final String successMsg;

  const RegisterSuccessState({required this.successMsg});

  @override
  List<Object> get props => [successMsg];

}


class UserCreateErrorState extends RegisterState {}
class UserCreateSuccessState extends RegisterState {}