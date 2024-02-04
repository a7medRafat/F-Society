import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/core/utiles/app_button.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/authentication/cubit/register_cubit/register_cubit.dart';
import 'package:fsociety/features/authentication/cubit/register_cubit/register_state.dart';
import 'package:fsociety/features/authentication/data/models/register_model.dart';
import 'package:fsociety/features/authentication/presentation/screens/login_screen/login_screen.dart';
import '../../../../../core/mysnackbar/mysnackbar.dart';
import '../../widgets/background.dart';
import '../../widgets/register/register_input_widget.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    super.key,
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Register',
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: size.height * 0.04),
                    const SizedBox(height: 10),
                    RegisterInputWidget(
                      c1: nameController,
                      c2: emailController,
                      c3: passwordController,
                      c4: phoneController,
                      fKey: formKey,
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccessState) {
                          MySnackBar()
                              .snackBarMessage(context, state.successMsg);
                          Future.delayed(const Duration(seconds: 1)).then(
                              (value) => Navigation()
                                  .navigateAndFinish(context, LoginScreen()));
                        }
                        if (state is RegisterErrorState) {
                          MySnackBar().snackBarMessage(context, state.msg);
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLoadingState) {
                          return const LoadingWidget();
                        }
                        return AppButton(
                            text: 'Register',
                            fun: () {
                              if (formKey.currentState!.validate()) {
                                RegisterBody register = RegisterBody(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                                di
                                    .sl<RegisterCubit>()
                                    .usrRegister(registerBody: register);
                              }
                            });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
