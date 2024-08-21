import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superfam_project/bloc/splash_bloc/splash_screen_bloc.dart';
import 'package:superfam_project/bloc/splash_bloc/splash_screen_events.dart';
import 'package:superfam_project/screens/login_screen.dart';
import '../bloc/splash_bloc/splash_screen_states.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc splashBloc;


  @override
  void initState() {
    splashBloc = SplashBloc();
    splashBloc.add(const NavigationSplashEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => splashBloc,
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is NavigationState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          },
          child: SafeArea(
            child: Center(
              child: Image.asset("assets/logo.png", width: MediaQuery.sizeOf(context).width / 1.4,),
            ),
          ),
        ),
      ),
    );
  }
}
