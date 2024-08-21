

abstract class LoginState {
  const LoginState();
}

class InitLoginState extends LoginState {
  const InitLoginState();
}

class SuccessLoginOTPState extends LoginState {
  final String phoneNumber;

  const SuccessLoginOTPState({required this.phoneNumber});
}

class ErrorLoginOTPState extends LoginState {
  final String errorMessage;

  const ErrorLoginOTPState({required this.errorMessage});
}

class SuccessVerifyOTPState extends LoginState {
  SuccessVerifyOTPState();
}

class ErrorVerifyOTPState extends LoginState {
  final String errorMessage;
  const ErrorVerifyOTPState({required this.errorMessage});
}