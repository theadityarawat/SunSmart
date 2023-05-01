import 'package:flutter/material.dart';
import 'package:solar_saver/Screens/home/home_screen.dart';
import '../../../size_config.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.asset('logo.png', height: getProportionateScreenHeight(25),),
          )
          
        ],
      ),
    );
  }
}
