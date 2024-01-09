import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import '../../../../core/failures_message/failures_messages.dart';
import '../../domain/usecases/user_login.dart';
import 'package:fsociety/injuctoin_container.dart' as di;
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.userLoginUseCase}) : super(LoginInitial());
  final UserLoginUseCase userLoginUseCase;

  void userLogin({required String email, required String password}) async {
    emit(LoginLoadingState());
    final failureOrSuccess = await userLoginUseCase.call(email, password);
    failureOrSuccess
        .fold((failure) => emit(LoginErrorState(msg: failureMessage(failure))),
            (success) async {
      di.sl<FeedsCubit>().getAllPosts();
      di.sl<StoryCubit>().getAllStories();
      emit(LoginSuccessState(
          successMsg: 'login successfully', uid: success.user!.uid));
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut().then((value) {
      di.sl<FeedsCubit>()
        ..posts = []
        ..likes = []
        ..comments = []
        ..commentColors = []
        ..saved = []
        ..savedList = [];
      di.sl<StoryCubit>().validStories = [];
      emit(LogoutSuccessState());
    }).catchError((error) {
      print("Error signing out: $error");
    });
  }
}
