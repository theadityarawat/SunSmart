import 'package:flutter/material.dart';
import 'package:solar_saver/size_config.dart';
import 'package:solar_saver/Screens/home_old/Components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:Body(),
    );
  }
}
