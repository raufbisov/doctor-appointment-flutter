import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/appointment/presentation/pages/main_page.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/register_page.dart';
import 'package:doctor_appointment/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is LoggedIn) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(activeUser: state.user),
                    ));
              });
            } else if (state is LoggingProcess) {
              return const CircularProgressIndicator();
            } else if (state is AuthError) {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  state.message,
                  style: theme.textTheme.caption!.copyWith(color: Colors.white),
                )));
              });
            }
            return SizedBox(
              height: device.size.height * .9,
              width: device.size.width * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Xoş Gəlmisiniz!',
                      style: theme.textTheme.headline4!
                          .copyWith(color: Colors.black)),
                  SizedBox(height: device.size.height * .1),
                  Form(
                    child: Column(
                      children: [
                        CustomTextFormField(
                            theme: theme,
                            label: 'Email',
                            controller: emailController),
                        SizedBox(height: device.size.height * .02),
                        CustomTextFormField(
                          theme: theme,
                          label: 'Şifrə',
                          controller: passwordController,
                          isObscure: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: device.size.height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const RegisterPage()));
                        },
                        child: Text(
                          'Şifrəni unutmusan?',
                          style: theme.textTheme.button,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: device.size.height * .1),
                  MaterialButton(
                    color: theme.colorScheme.secondary,
                    height: device.size.height * .07,
                    minWidth: device.size.width * .9,
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          LoginEvent(
                              email: emailController.text,
                              password: passwordController.text));
                    },
                    child: Text('Daxil ol',
                        style: theme.textTheme.button!
                            .copyWith(color: Colors.white)),
                  ),
                  SizedBox(height: device.size.height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hesabınız yoxdur? ',
                        style: theme.textTheme.button,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                        },
                        child: Text(
                          'Qeydiyyat',
                          style: theme.textTheme.button!
                              .copyWith(color: theme.colorScheme.secondary),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
