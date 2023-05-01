import 'package:flutter/widgets.dart';
import 'package:solar_saver/Screens/home/components/solar_output.dart';
import 'package:solar_saver/Screens/splash/splash_screen.dart';
import 'package:solar_saver/Screens/home/home_screen.dart';
// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) =>HomeScreen(),
  // SolarOutput.routeName: (context) =>SolarOutput(),
};
