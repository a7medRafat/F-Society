// ignore_for_file: void_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:fsociety/features/authentication/cubit/login_cubit/login_state.dart';
import 'package:fsociety/features/layout/presentation/screens/App_Layout.dart';
import 'package:fsociety/features/layout/presentation/screens/feeds_screen.dart';
import '../../../../../core/local_storage/hive_keys.dart';
import '../../../../../core/local_storage/user_storage.dart';
import '../../../../../core/mysnackbar/mysnackbar.dart';
import '../../../../../core/navigation/navigation.dart';
import '../../../../../core/utiles/app_button.dart';
import '../../widgets/background.dart';
import '../../widgets/login/face_and_google_widget.dart';
import '../../widgets/login/login_input_widget.dart';
import '../../widgets/login/login_text_widget.dart';
import '../../widgets/login/or_divider_widget.dart';
import '../../widgets/login/register_now_widget.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: ScaffoldMessenger(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(20),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LoginTextWidget(),
                      LoginInputWidget(
                        controller1: emailController,
                        controller2: passwordController,
                        fKey: loginKey,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            MySnackBar().snackBarMessage(context, state.successMsg);
                            Navigation().navigateAndFinish(context, AppLayout());
                          }
                          else if (state is LoginErrorState) {
                            return MySnackBar()
                                .snackBarMessage(context, state.msg);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return LoadingWidget();
                          }
                          return AppButton(
                              text: 'Login',
                              fun: () {
                                if (loginKey.currentState!.validate()) {
                                   di.sl<LoginCubit>().userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              });
                        },
                      ),
                      const RegisterNowWidget(),
                      const OrDivider(),
                      SizedBox(height: 20),
                      const FaceAndGoogleWidget()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
