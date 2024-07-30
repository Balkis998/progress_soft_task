import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends LoginState {}

class AuthLoading extends LoginState {}

class AuthCodeSent extends LoginState {
  final String verificationId;

  const AuthCodeSent(this.verificationId);
}

class AuthSuccess extends LoginState {}

class AuthFailure extends LoginState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class UserNotRegistered extends LoginState {}
