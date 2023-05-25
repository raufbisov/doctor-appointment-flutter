import 'package:doctor_appointment/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_timetable/simple_timetable.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late PageController _monthController;
  late PageController _dayController;
  late DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    _monthController = PageController(viewportFraction: .3);
    _dayController = PageController(viewportFraction: .3);
    super.initState();
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final device = MediaQuery.of(context);
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        debugPrint('$state');
        if (state is Empty) {
          BlocProvider.of<AppointmentBloc>(context)
              .add(ReadAllAppointmentsEvent());
        } else if (state is Loading) {
          return const CircularProgressIndicator();
        } else if (state is AppointmentError) {
          return const Text('Empty');
        } else if (state is Loaded) {
          return SimpleTimetable(
            events: getEvents(state),
            onChange: (currentColumns, dir) {
              setState(() {
                _selectedDate = currentColumns[0];
              });
            },
            initialDate: _selectedDate,
            dayStart: 0,
            dayEnd: 24,
            visibleRange: 1,
            buildCard: (event, isPast) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                    color: isPast
                        ? Colors.grey[400]
                        : Colors.blue[200]!.withOpacity(0.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text(
                        '${event.start..toString()}\n${event.end.toString()}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  List<Event> getEvents(Loaded state) {
    List<Event> eventList = [];
    for (var app in state.appointmentList) {
      eventList.add(Event(
        id: UniqueKey().toString(),
        start: app.startTime,
        end: app.endTime,
        date: app.startTime,
        title: app.title,
      ));
    }
    return eventList;
  }
}
