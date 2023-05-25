import 'package:doctor_appointment/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:doctor_appointment/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  late TextEditingController titleController;
  late DateTime startTime = DateTime.now();
  late DateTime endTime = DateTime.now();
  late String doctorId = '';
  late User activeDoctor = const User(
    id: '',
    firstName: 'Həkim',
    lastName: 'adı',
    age: 0,
    email: '',
    phoneNumber: '',
    group: Group.Employee,
    gender: Gender.None,
  );

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AppointmentBloc, AppointmentState>(
            builder: (context, state) {
              if (state is Loaded) {
                return SizedBox(
                  height: device.size.height * .9,
                  width: device.size.width * .9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Görüş təyin edin',
                          style: theme.textTheme.headline4!
                              .copyWith(color: Colors.black)),
                      SizedBox(height: device.size.height * .1),
                      Form(
                        child: Column(
                          children: [
                            CustomTextFormField(
                                theme: theme,
                                label: 'Başlıq',
                                controller: titleController),
                            SizedBox(height: device.size.height * .03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Başlama tarixi:',
                                  style: theme.textTheme.labelLarge,
                                ),
                                SizedBox(width: device.size.width * .05),
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: startTime,
                                            firstDate:
                                                DateTime(startTime.year - 3),
                                            lastDate:
                                                DateTime(startTime.year + 5))
                                        .then((value) {
                                      setState(() {
                                        value != null
                                            ? startTime = DateTime(
                                                value.year,
                                                value.month,
                                                value.day,
                                                startTime.hour,
                                                startTime.minute)
                                            : null;
                                      });
                                    });
                                  },
                                  child: Text(DateFormat('yyyy-MM-dd')
                                      .format(startTime)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Başlama vaxtı:',
                                  style: theme.textTheme.labelLarge,
                                ),
                                SizedBox(width: device.size.width * .05),
                                GestureDetector(
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      setState(() {
                                        value != null
                                            ? startTime = DateTime(
                                                startTime.year,
                                                startTime.month,
                                                startTime.day,
                                                value.hour,
                                                value.minute)
                                            : null;
                                      });
                                    });
                                  },
                                  child: Text(
                                      DateFormat('HH-mm').format(startTime)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bitmə tarixi:',
                                  style: theme.textTheme.labelLarge,
                                ),
                                SizedBox(width: device.size.width * .05),
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: endTime,
                                            firstDate:
                                                DateTime(endTime.year - 3),
                                            lastDate:
                                                DateTime(endTime.year + 5))
                                        .then((value) {
                                      setState(() {
                                        value != null
                                            ? endTime = DateTime(
                                                value.year,
                                                value.month,
                                                value.day,
                                                endTime.hour,
                                                endTime.minute)
                                            : null;
                                      });
                                    });
                                  },
                                  child: Text(
                                      DateFormat('yyyy-MM-dd').format(endTime)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bitmə vaxtı:',
                                  style: theme.textTheme.labelLarge,
                                ),
                                SizedBox(width: device.size.width * .05),
                                GestureDetector(
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      setState(() {
                                        value != null
                                            ? endTime = DateTime(
                                                endTime.year,
                                                endTime.month,
                                                endTime.day,
                                                value.hour,
                                                value.minute)
                                            : null;
                                      });
                                    });
                                  },
                                  child:
                                      Text(DateFormat('HH-mm').format(endTime)),
                                ),
                              ],
                            ),
                            DropdownButton<String>(
                              items: getItems(state.doctorList),
                              onChanged: (value) {
                                setState(() {
                                  debugPrint(value);
                                  doctorId = value!;
                                  for (var doctor in state.doctorList) {
                                    doctor.id == doctorId
                                        ? activeDoctor = doctor
                                        : null;
                                  }
                                });
                              },
                              hint: Text('Həkim',
                                  style: theme.textTheme.subtitle1),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: device.size.height * .01),
                      MaterialButton(
                        color: theme.colorScheme.secondary,
                        height: device.size.height * .07,
                        minWidth: device.size.width * .9,
                        onPressed: () {
                          var state =
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .state;
                          if (state is LoggedIn) {
                            setState(() {
                              BlocProvider.of<AppointmentBloc>(context).add(
                                  CreateAppointmentEvent(
                                      title: titleController.text,
                                      startTime: startTime,
                                      endTime: endTime,
                                      employeeId: doctorId,
                                      patientId: state.user.id));
                            });
                          }
                        },
                        child: Text('Yarat',
                            style: theme.textTheme.button!
                                .copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> getItems(List<User> doctorList) {
  List<DropdownMenuItem<String>> itemList = [];
  for (var doctor in doctorList) {
    itemList.add(
      DropdownMenuItem<String>(
        value: doctor.id,
        child: Text('${doctor.firstName} ${doctor.lastName}'),
      ),
    );
  }
  return itemList;
}
