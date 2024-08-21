import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:superfam_project/bloc/login_bloc/login_bloc.dart';
import 'package:superfam_project/bloc/login_bloc/login_bloc_events.dart';
import 'package:superfam_project/bloc/login_bloc/login_bloc_states.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController otpTextController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool didTimerEnd = false;
  int levelClock = 30;
  bool hasError = false;
  String? errorCatcher = "";
  bool _otpSent = false;
  bool enableButton = true;
  TextEditingController phoneController = TextEditingController();
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LoginBloc();
    super.initState();
  }

  @override
  void dispose() {
    // otpTextController.dispose();
    // phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginOTPState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OTPScreen(
                  phoneNumber: state.phoneNumber,
                ),
              ),
            );
          }
          if (state is ErrorLoginOTPState) {
            debugPrint("Error Login OTP State: ${state.errorMessage}");
            _otpSent = false;
            errorCatcher = state.errorMessage;
            errorCatcher = "Enter valid number";
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 1.1,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Welcome to SuperFam",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        "assets/undraw_Login_re_4vu2 (1).png",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const Text(
                        "Login to your account.",
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        enabled: !_otpSent,
                        decoration: InputDecoration(
                          hintText: "Enter Phone Number",
                          prefixText: "+91  ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          errorCatcher ?? "",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "By signing in you agree to our ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          loginBloc.add(LoginOTPEvent(phoneNumber: phoneController.text));
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: Colors.black,
                                width: 1.0),
                          ),
                          child: Center(
                            child: Text(
                              _otpSent ? "Login" : "Send OTP",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        // child: ,
      ),
    );
  }
}
