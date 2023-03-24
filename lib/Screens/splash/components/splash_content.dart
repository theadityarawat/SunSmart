import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(380),
          width: getProportionateScreenWidth(400),
        ),
        // Text(
        //   text!,
        //   textAlign: TextAlign.center,
        // ),
        Spacer(),

      ],
    );
  }
}
