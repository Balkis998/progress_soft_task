import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends LoginEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SendCodePressed extends LoginEvent {}

class VerifyCodePressed extends LoginEvent {
  final String code;

  const VerifyCodePressed(this.code);

  @override
  List<Object> get props => [code];
}
