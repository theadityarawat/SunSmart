import 'package:flutter/material.dart';
import 'package:solar_saver/routes.dart';
import 'package:solar_saver/components/usables.dart';
import 'package:solar_saver/constants.dart';
import 'package:solar_saver/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:solar_saver/default_button.dart';
import 'package:solar_saver/Screens/home/home_screen.dart';

class SolarOutput extends StatefulWidget {
  double ac_annual=0.0;
  double solarRad_annual=0.0;
  double cap_factor=0.0;
  String ResLink='https://solarrooftop.gov.in/grid_others/discomPortalLink';
  String Res2Link='https://solarrooftop.gov.in';

  SolarOutput({required this.ac_annual, required this.solarRad_annual, required this.cap_factor});

  @override
  State<SolarOutput> createState() => _SolarOutputState();
}

class _SolarOutputState extends State<SolarOutput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('Solar Output', style: kLabelTextStyle.copyWith(fontSize: 35),),
        centerTitle: true,
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: box(color: kMainColor,
                    cardChild: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10),),
                        Text("Annual AC Output", style: kLabelTextStyle,textAlign: TextAlign.center,),
                        SizedBox(height: getProportionateScreenHeight(10),),
                        Text(widget.ac_annual.toStringAsFixed(2), style: kBoldStyle.copyWith(color: kMainLightColor, fontFamily: 'Montserrat_bold', fontSize: 30),),
                        SizedBox(height: getProportionateScreenHeight(10),),
                      ],
                    ),
                    onpress: (){} )),
                Expanded(child: box(color: kMainColor,
                    cardChild: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10),),
                        Text("Annual Solar Radiation", style: kLabelTextStyle,textAlign: TextAlign.center,),
                        SizedBox(height: getProportionateScreenHeight(10),),
                        Text(widget.solarRad_annual.toStringAsFixed(2), style: kBoldStyle.copyWith(color: kMainLightColor, fontFamily: 'Montserrat_bold', fontSize: 30),),
                        SizedBox(height: getProportionateScreenHeight(10),),
                      ],
                    ),
                    onpress: (){} ))
              ],
            ),
            box(
                color: kMainColor,
                cardChild: Column(
                  children: [
                    SizedBox(height: 10, width: getProportionateScreenWidth(350),),
                    Text("Capacity", style: kLabelTextStyle, textAlign: TextAlign.center,),
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Text(widget.cap_factor.toStringAsFixed(2),style: kBoldStyle.copyWith(color: kMainLightColor, fontFamily: 'Montserrat_bold', fontSize: 40), )
                  ],
                ), onpress: () { }),
            box(
                color: kMainColor,
                cardChild: Column(
                  children: [
                    SizedBox(height: 10, width: getProportionateScreenWidth(350),),
                    Text("Efficiency", style: kLabelTextStyle, textAlign: TextAlign.center,),
                    SizedBox(height: getProportionateScreenHeight(10),),
                    Text((widget.cap_factor/22.8*100).toStringAsFixed(2),style: kBoldStyle.copyWith(color: kMainLightColor, fontFamily: 'Montserrat_bold', fontSize: 40), )
                  ],
                ), onpress: () { }),
          SizedBox(height: getProportionateScreenHeight(15),),
            DefaultButton(text: 'Go to Solar Portal, Govt of India', press: () async{
              if (await canLaunchUrl(Uri.parse(widget.Res2Link)))
                await launchUrl(Uri.parse(widget.Res2Link));
              else
                // can't launch url, there is some error
                throw "Could not launch $widget.Res2Link";}),
            SizedBox(height: getProportionateScreenHeight(15),),
          DefaultButton(text: 'Get links to Govt Solar Vendors', press: () async{
            if (await canLaunchUrl(Uri.parse(widget.ResLink)))
            await launchUrl(Uri.parse(widget.ResLink));
            else
            // can't launch url, there is some error
            throw "Could not launch $widget.ResLink";}),
            SizedBox(height: getProportionateScreenHeight(15),),
            lastButton(seen: 'Go Back to Inputs', onTapp: () {Navigator.pushNamed(context, HomeScreen.routeName);})
          ],
        ),
      )
    );
  }
}
