part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class PhoneCodeSent extends RegisterState {
  final String verificationId;

  PhoneCodeSent(this.verificationId);
}

class PhoneVerificationCompleted extends RegisterState {
  final PhoneAuthCredential credential;

  PhoneVerificationCompleted(this.credential);
}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}
