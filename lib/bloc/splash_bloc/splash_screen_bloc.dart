import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:superfam_project/bloc/splash_bloc/splash_screen_events.dart';
import 'package:superfam_project/bloc/splash_bloc/splash_screen_states.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const InitSplashState()) {
    on<NavigationSplashEvent>((event, emit) async {
      await Future.delayed(
        const Duration(seconds: 5),
        () {
          emit(const NavigationState());
        },
      );
    });
  }
}
