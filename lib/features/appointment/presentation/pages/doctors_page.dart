import 'package:doctor_appointment/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is Loaded) {
          return ListView.builder(
            itemCount: state.doctorList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text(
                    '${state.doctorList[index].firstName} ${state.doctorList[index].lastName}'),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
