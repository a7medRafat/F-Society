import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/authentication/domain/usecases/facebook_sign_in.dart';
import 'package:fsociety/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/messages/cubit/messages_cubit.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import '../../domain/usecases/user_login.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {required this.userLoginUseCase,
      required this.googleSignInUseCase,
      required this.facebookSignInUseCase})
      : super(LoginInitial());
  final UserLoginUseCase userLoginUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final FacebookSignInUseCase facebookSignInUseCase;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void userLogin({required String email, required String password}) async {
    emit(LoginLoadingState());
    final failureOrSuccess = await userLoginUseCase.call(email, password);
    failureOrSuccess
        .fold((failure) => emit(LoginErrorState(msg: failure.getMessage())),
            (success) async {
      di.sl<FeedsCubit>().getAllPosts();
      di.sl<StoryCubit>().getAllStories();
      di.sl<MessagesCubit>().getUsers();

      emit(LoginSuccessState(successMsg: 'login successfully', uid: success.user!.uid));
    });
  }

  void googleSignIn() async {
    emit(GoogleSigningLoadingState());
    final failureOrSuccess = await googleSignInUseCase.call();
    failureOrSuccess.fold((failure) => emit(GoogleSigningErrorState()),
        (success) {
      di.sl<FeedsCubit>().getAllPosts();
      di.sl<StoryCubit>().getAllStories();
      emit(GoogleSigningSuccessState(googleMsg: 'login successfully'));
    });
  }

  void facebookSignIn() async {
    emit(FaceBookSigningLoadingState());
    final failureOrSuccess = await facebookSignInUseCase.call();
    failureOrSuccess.fold((failure) => emit(FaceBookSigningErrorState()),
        (success) {
      di.sl<FeedsCubit>().getAllPosts();
      di.sl<StoryCubit>().getAllStories();
      di.sl<MessagesCubit>().getUsers();
      emit(FaceBookSigningSuccessState(facebookMsg: 'login successfully'));
    });
  }

  Future<void> signOut() async {
    await _auth.signOut().then((value) {
      di.sl<FeedsCubit>()
        ..posts = []
        ..likes = []
        ..colors = []
        ..comments = []
        ..commentColors = []
        ..saved = []
        ..commentsNum = [];
      di.sl<StoryCubit>().validStories = [];
      di.sl<ProfileCubit>()
        ..myPosts = []
        ..mySaved = [];
      di.sl<MessagesCubit>().allUsers = [];
      emit(LogoutSuccessState());
    }).catchError((error) {
      print("Error signing out: $error");
    });
  }
}
