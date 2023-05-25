import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/initial_page.dart';
import 'package:doctor_appointment/features/appointment/presentation/pages/main_page.dart';
import 'package:doctor_appointment/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalPage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AdditionalPage(
      {super.key,
      required this.emailController,
      required this.passwordController});

  @override
  State<AdditionalPage> createState() => _AdditionalPageState();
}

class _AdditionalPageState extends State<AdditionalPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController ageController;
  late Gender gender = Gender.None;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    ageController.dispose();
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
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MainPage(activeUser: state.user),
                      ),
                      (route) =>
                          route ==
                          MaterialPageRoute(
                            builder: (context) => const InitialPage(),
                          ));
                });
              } else if (state is LoggingProcess) {
                return const CircularProgressIndicator();
              }
              return SizedBox(
                height: device.size.height * .9,
                width: device.size.width * .9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Əlavə məlumatlar',
                        style: theme.textTheme.headline4!
                            .copyWith(color: Colors.black)),
                    SizedBox(height: device.size.height * .1),
                    Form(
                      child: Column(
                        children: [
                          CustomTextFormField(
                              theme: theme,
                              label: 'Ad',
                              controller: firstNameController),
                          SizedBox(height: device.size.height * .02),
                          CustomTextFormField(
                              theme: theme,
                              label: 'Soyad',
                              controller: lastNameController),
                          SizedBox(height: device.size.height * .02),
                          CustomTextFormField(
                              theme: theme,
                              label: 'Mobil nömrə',
                              controller: phoneNumberController),
                          SizedBox(height: device.size.height * .02),
                          CustomTextFormField(
                              theme: theme,
                              label: 'Yaş',
                              controller: ageController),
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
                        debugPrint(widget.emailController.text);
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          RegisterEvent(
                            email: widget.emailController.text,
                            password: widget.passwordController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumberController.text,
                            age: int.parse(ageController.text),
                            gender: gender,
                          ),
                        );
                      },
                      child: Text('Hesab yarat',
                          style: theme.textTheme.button!
                              .copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
