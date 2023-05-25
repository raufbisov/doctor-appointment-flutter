import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.age,
    required super.email,
    required super.phoneNumber,
    required super.group,
    required super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      group: json['is_employee'] ? Group.Employee : Group.Patient,
      gender: getGender(json['gender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'email': email,
      'phone_number': phoneNumber,
      'is_employee': group == Group.Employee ? true : false,
    };
  }
}

Gender getGender(String gender) {
  if (gender == 'Male') {
    return Gender.Male;
  } else if (gender == 'Female') {
    return Gender.Female;
  } else {
    return Gender.None;
  }
}
