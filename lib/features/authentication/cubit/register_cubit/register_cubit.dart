import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/authentication/cubit/register_cubit/register_state.dart';
import 'package:fsociety/features/authentication/data/models/register_model.dart';
import 'package:fsociety/features/authentication/domain/usecases/user_registration.dart';
import '../../../../core/failures_message/failures_messages.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.userRegistrationUseCase}) : super(RegisterInitial());
  final UserRegistrationUseCase userRegistrationUseCase;

  static RegisterCubit get(context) => BlocProvider.of(context);


  void usrRegister({required RegisterBody registerBody}) async {
    emit(RegisterLoadingState());
    final failureOrSuccess = await userRegistrationUseCase.call(registerBody: registerBody);
    failureOrSuccess.fold(
        (failure) => emit(RegisterErrorState(msg: failureMessage(failure))),
        (success) => emit(RegisterSuccessState(successMsg: 'successfully registered')));
  }


}
