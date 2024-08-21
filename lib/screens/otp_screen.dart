import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:superfam_project/bloc/login_bloc/login_bloc_events.dart';
import 'package:superfam_project/bloc/login_bloc/login_bloc_states.dart';
import '../bloc/login_bloc/login_bloc.dart';
import 'login_screen.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPScreen({super.key, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool enableButton = false;
  String? errorCatcher = "";
  TextEditingController otpTextController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  bool _rememberMeCheckbox = false;

  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessVerifyOTPState) {
            debugPrint("Success Verify OTP");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: const Text("Login Success!"),
                  content: const Text(
                      "You have been successfully Logged-in to your account."),
                  actionsPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false);
                      },
                    ),
                  ],
                );
              },
            );
          }
          if (state is ErrorVerifyOTPState) {
            debugPrint("Error Verify OTP");
            errorController!.add(ErrorAnimationType.shake);
            errorCatcher = state.errorMessage;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black12,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 30,
                        ),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        "assets/undraw_Authentication_re_svpt (1).png",
                        width: MediaQuery.sizeOf(context).width / 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Enter OTP",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "A 4 digit code has been sent to \n+91 ${widget.phoneNumber}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        animationType: AnimationType.scale,
                        errorAnimationController: errorController,
                        pinTheme: PinTheme(
                          activeColor: Colors.black54,
                          selectedColor: Colors.black54,
                          inactiveColor: Colors.black54,
                          errorBorderColor: Colors.black54,
                          borderWidth: 1,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 64,
                          fieldWidth: MediaQuery.sizeOf(context).width * 0.12,
                          // fieldWidth: widget.verificationID != null
                          //     ? MediaQuery.sizeOf(context).width * 0.12
                          //     : 64,
                          activeFillColor: Colors.white,
                        ),
                        boxShadows: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            blurStyle: BlurStyle.inner,
                            spreadRadius: 0,
                            color: hasError ? Colors.red : Colors.black26,
                            blurRadius: 0,
                          ),
                          const BoxShadow(
                            offset: Offset(0, 0),
                            blurStyle: BlurStyle.inner,
                            spreadRadius: 0,
                            color: Colors.white,
                            blurRadius: 0,
                          ),
                        ],
                        cursorColor: const Color(0xFFD8D8D8),
                        controller: otpTextController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (pin) {
                          debugPrint(pin);
                          setState(() {
                            errorCatcher = "";
                          });
                          if (pin.length == 6) {
                            setState(
                              () {
                                enableButton = true;
                              },
                            );
                          } else {
                            setState(
                              () {
                                enableButton = false;
                              },
                            );
                          }
                        },
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
                    CheckboxListTile(
                      value: _rememberMeCheckbox,
                      contentPadding: EdgeInsets.zero,
                      activeColor: Colors.blue,
                      visualDensity: const VisualDensity(horizontal: -4),
                      onChanged: (newVaue) {
                        setState(
                          () {
                            _rememberMeCheckbox = newVaue!;
                          },
                        );
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text("Remember me"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (_otpSent == false) {
                        //   loginBloc.add(LoginOTPEvent(
                        //       phoneNumber: phoneController.text));
                        // } else if (_otpSent && _enableButton) {
                        //   loginBloc.add(const VerifyOTPEvent());
                        // }
                        loginBloc
                            .add(VerifyOTPEvent(otp: otpTextController.text));
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color:
                                  enableButton ? Colors.black : Colors.black38,
                              width: 1.0),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color:
                                  enableButton ? Colors.black : Colors.black38,
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
        ),
      ),
    );
  }
}
