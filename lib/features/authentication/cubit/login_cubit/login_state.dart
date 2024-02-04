import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

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

class LogoutSuccessState extends LoginState {}

class GoogleSigningLoadingState extends LoginState {}
class GoogleSigningSuccessState extends LoginState {
  final String googleMsg;

  GoogleSigningSuccessState({required this.googleMsg});

}
class GoogleSigningErrorState extends LoginState {}


class FaceBookSigningLoadingState extends LoginState {}
class FaceBookSigningSuccessState extends LoginState {
  final String facebookMsg;

  FaceBookSigningSuccessState({required this.facebookMsg});

}
class FaceBookSigningErrorState extends LoginState {}