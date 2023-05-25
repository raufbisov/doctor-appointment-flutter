// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String email;
  final String phoneNumber;
  final Group group;
  final Gender gender;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.group,
    required this.gender,
  });

  @override
  List<Object?> get props => [];
}

enum Group { Employee, Patient }

enum Gender { Male, Female, None }
