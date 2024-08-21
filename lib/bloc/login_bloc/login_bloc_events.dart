import 'package:equatable/equatable.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginOTPEvent extends LoginEvent {
  final String phoneNumber;
  const LoginOTPEvent({required this.phoneNumber});

  @override
  List<Object> get props => [];
}

class VerifyOTPEvent extends LoginEvent {
  final String otp;

  const VerifyOTPEvent({required this.otp});

  @override
  List<Object> get props => [];
}