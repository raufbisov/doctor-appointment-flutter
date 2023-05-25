import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/login_page.dart';
import 'package:doctor_appointment/features/appointment/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              debugPrint('$state');
              if (state is LoggedIn) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MainPage(activeUser: state.user),
                  ));
                });
              } else if (state is LoggedOut || state is AuthError) {
                if (state is AuthError) {
                  debugPrint(state.message);
                }
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                });
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
