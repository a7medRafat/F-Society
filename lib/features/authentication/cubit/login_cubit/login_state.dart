import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String msg;

  LoginErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}

class LoginSuccessState extends LoginState {
  final String successMsg;
  final String uid;

  LoginSuccessState({required this.uid,required this.successMsg});

  @override
  List<Object> get props => [successMsg];

}

class LogoutSuccessState extends LoginState {
  @override
  List<Object> get props => [];

}