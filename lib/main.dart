import 'package:doctor_appointment/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              di.sl<AuthenticationBloc>()..add(CheckAuthEvent()),
        ),
        BlocProvider<AppointmentBloc>(
          create: (context) => di.sl<AppointmentBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primaryColorDark: const Color.fromRGBO(35, 87, 137, 1),
            backgroundColor: const Color.fromRGBO(221, 219, 203, 1),
            accentColor: const Color.fromARGB(255, 34, 122, 68),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const InitialPage(),
      ),
    );
  }
}
