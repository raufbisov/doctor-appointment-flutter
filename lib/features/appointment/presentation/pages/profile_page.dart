import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final theme = Theme.of(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return Column(
            children: [
              Text('${state.user.firstName} ${state.user.lastName}'),
              SizedBox(height: device.size.height * .01),
              Text(state.user.phoneNumber),
              SizedBox(height: device.size.height * .01),
              Text(
                  '${state.user.age}, ${state.user.gender == Gender.Female ? "Qadın" : "Kişi"}'),
              SizedBox(height: device.size.height * .01),
              MaterialButton(
                color: theme.colorScheme.secondary,
                height: device.size.height * .07,
                minWidth: device.size.width * .9,
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(LogoutEvent());
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
                },
                child: Text('Çıxış',
                    style:
                        theme.textTheme.button!.copyWith(color: Colors.white)),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
