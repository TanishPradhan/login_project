import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:superfam_project/bloc/login_bloc/login_bloc_events.dart';
import 'package:superfam_project/bloc/login_bloc/login_bloc_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const InitLoginState()) {
    on<LoginOTPEvent>((event, emit) async {
      /*

        here, we will add functionality of login with OTP

      */

      if (event.phoneNumber.length != 10) {
        debugPrint("Error: Phone number length: ${event.phoneNumber.length}");

        emit(const ErrorLoginOTPState(
            errorMessage: "Please enter a valid phone number"));
      } else if (event.phoneNumber.length == 10) {
        debugPrint("Success: Phone number length: ${event.phoneNumber.length}");

        emit(SuccessLoginOTPState(phoneNumber: event.phoneNumber));
      }
    });

    on<VerifyOTPEvent>(
      (event, emit) {
        /*

        here, we will add functionality of OTP verification

        */

        if (event.otp.length != 6) {
          debugPrint("Error: OTP length: ${event.otp.length}");

          emit(const ErrorVerifyOTPState(
              errorMessage: "Please enter a valid OTP"));
        } else if (event.otp.length == 6) {
          debugPrint("Success: OTP length: ${event.otp.length}");

          emit(SuccessVerifyOTPState());
        }
      },
    );
  }
}
