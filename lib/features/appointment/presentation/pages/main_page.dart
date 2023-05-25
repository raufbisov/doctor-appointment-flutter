import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/appointment/presentation/pages/add_appointment_page.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/login_page.dart';
import 'package:doctor_appointment/features/appointment/presentation/pages/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  final User activeUser;
  const MainPage({super.key, required this.activeUser});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgets = [
    SchedulePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final device = MediaQuery.of(context);
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SizedBox(
            height: device.size.height * .9,
            width: device.size.width * .9,
            child: _widgets.elementAt(_selectedIndex),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Cədvəl',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'İşçilər',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.secondary,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAppointmentPage(),
                    ));
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  MaterialButton logoutButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
      },
      color: Colors.blue,
      child: const Text('Logout'),
    );
  }
}
