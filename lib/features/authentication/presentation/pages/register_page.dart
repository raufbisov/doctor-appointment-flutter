import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/additional_page.dart';
import 'package:doctor_appointment/features/authentication/presentation/pages/login_page.dart';
import 'package:doctor_appointment/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
              return SizedBox(
                height: device.size.height * .9,
                width: device.size.width * .9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Qeydiyyat',
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdditionalPage(
                                      emailController: emailController,
                                      passwordController: passwordController,
                                    )));
                      },
                      child: Text('Davam et',
                          style: theme.textTheme.button!
                              .copyWith(color: Colors.white)),
                    ),
                    SizedBox(height: device.size.height * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hesabınız var? ',
                          style: theme.textTheme.button,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: Text(
                            'Daxil ol',
                            style: theme.textTheme.button!
                                .copyWith(color: theme.colorScheme.secondary),
                          ),
                        ),
                      ],
                    )
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
