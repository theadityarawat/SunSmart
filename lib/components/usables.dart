import 'package:flutter/material.dart';
import 'package:solar_saver/constants.dart';

class lastButton extends StatelessWidget {
  lastButton({required this.seen, required this.onTapp});
  String seen;
  Function onTapp;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              child: Text(
                seen,
                style: kLabelTextStyle,
              ),
              onTap: () {
                onTapp();
              }),
        ],
      ),
      decoration: BoxDecoration(color: kMainColor),
      height: 80,
      width: double.maxFinite,
    );
  }
}

class box extends StatelessWidget {
  box({required this.color, required this.cardChild, required this.onpress});
  final Color color;
  final Widget cardChild;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        child: cardChild,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        margin: EdgeInsets.all(15),
      ),
    );
  }
}
class cardContent extends StatelessWidget {
  cardContent({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 85,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        )
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 45.0,
        height: 45.0,
      ),
      disabledElevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      fillColor: Color(0xFFA7FF84),
    );
  }
}