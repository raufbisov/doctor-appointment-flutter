import 'package:equatable/equatable.dart';

abstract class Response extends Equatable {}

class Failure extends Response {
  final String message;
  Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class StorageFailure extends Failure {
  StorageFailure(super.message);

  @override
  List<Object?> get props => [message];
}

class Success extends Response {
  @override
  List<Object?> get props => [];
}
