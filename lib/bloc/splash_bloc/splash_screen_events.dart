import 'package:equatable/equatable.dart';


abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class NavigationSplashEvent extends SplashEvent {
  const NavigationSplashEvent();

  @override
  List<Object> get props => [];
}