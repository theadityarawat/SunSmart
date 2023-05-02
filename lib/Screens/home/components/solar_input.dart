import 'package:flutter/material.dart';
import 'package:solar_saver/components/location_model.dart';
import '../../../size_config.dart';
import 'package:solar_saver/constants.dart';
import 'solar_output.dart';
import 'package:solar_saver/components/usables.dart';


class InputForm extends StatefulWidget {
  InputForm({this.locationDetails});
  final locationDetails;

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  LocationModel loc = LocationModel();
  double latitude = 0.0;
  double longitude = 0.0;
  int sysCap = 4;
  int azi = 180;
  int tilt = 20;
  int arrayType = 0;
  int moduleType = 0;
  double losses = 14.08;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationDetails);
  }

  void updateUI(dynamic locationCity) {
    setState(() {
      if (locationCity == null) {
        latitude=0.0;
        longitude=0.0;
        return;
      }
      latitude = double.parse(locationCity['lat']);
      // latitude = 27.285890739264094;
      print(latitude);
      longitude = double.parse(locationCity['lon']);
      // longitude = 75.17452041931212;
      print(longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: box(
                color: kMainColor,
                cardChild: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("System Capacity", style: kLabelTextStyle,textAlign: TextAlign.center,),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          icon: Icons.remove,
                          onPressed: () {
                            setState(() {
                              sysCap--;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Text(sysCap.toString(), style: kBoldStyle,),
                        SizedBox(width: 10),
                        RoundIconButton(
                          icon: Icons.add,
                          onPressed: () {
                            setState(() {
                              sysCap++;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ), onpress: () async{ var locationCity = await loc.getLocation();
              updateUI(locationCity); },
              ),
            ),

            Expanded(
              child: box(
                color: kMainColor,
                cardChild: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("Losses", style: kLabelTextStyle,),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(
                          icon: Icons.remove,
                          onPressed: () {
                            setState(() {
                              losses -= 0.1;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Text(losses.toStringAsFixed(2), style: kBoldStyle.copyWith(fontSize: 20),),
                        SizedBox(width: 10),
                        RoundIconButton(
                          icon: Icons.add,
                          onPressed: () {
                            setState(() {
                              losses += 0.1;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ), onpress: () {  },
              ),
            ),
          ],
        ),
        box(color: kMainColor,
            cardChild: Column(
            children: [
              SizedBox(height: 10),
            Text("Azimuth Angle: \n $azi", style: kLabelTextStyle, textAlign: TextAlign.center,),
            Slider(
              activeColor: kMainLightColor,
              value: azi.toDouble(),
              min: 0,
              max: 360,
              onChanged: (double value) {
                setState(() {
                  azi = value.round();
                });
              },
            ),
          ],
        ), onpress: () { }),
        // SizedBox(height: 10.0),
        box(
          color: kMainColor,
          cardChild: Column(
            children: [
              SizedBox(height: 10),
              Text("Tilt Angle: \n $tilt", style: kLabelTextStyle, textAlign: TextAlign.center,),
              Slider(
                activeColor: kMainLightColor,
                value: tilt.toDouble(),
                min: 0.0,
                max: 90.0,
                onChanged: (double value) {
                  setState(() {
                    tilt = value.round();
                  });
                },
              ),
            ],
          ), onpress: () {  },
        ),
        Row(
          children: [
            Expanded(
              child: box(
                color: kMainColor,
                cardChild: Column(
                  children: [
                    SizedBox(height: 10),
                    Text("Array Type", style: kLabelTextStyle, textAlign: TextAlign.center,),
                    DropdownButton<int>(
                      dropdownColor: kMainColor,
                      isExpanded: true,
                      value: arrayType,
                      items: [
                        DropdownMenuItem(
                          child: Text(" Fixed - Open Rack", style: TextStyle(color: Colors.white),),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text("	Fixed - Roof ", style: TextStyle(color: Colors.white),),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("1-Axis", style: TextStyle(color: Colors.white),),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("1-Axis Backtracking", style: TextStyle(color: Colors.white),),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("2-Axis", style: TextStyle(color: Colors.white),),
                          value: 4,
                        ),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          arrayType = value ?? 0; // use 0 as default value if value is null
                        });
                      },
                      selectedItemBuilder: (BuildContext context) {
                        return [
                          DropdownMenuItem<int>(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Fixed - Open Rack", style: TextStyle(color: Colors.white)),
                            ),
                            value: 0,
                          ),
                          DropdownMenuItem<int>(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Fixed - Roof", style: TextStyle(color: Colors.white)),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem<int>(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("1-Axis", style: TextStyle(color: Colors.white)),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem<int>(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("1-Axis Backtracking", style: TextStyle(color: Colors.white)),
                            ),
                            value: 3,
                          ),
                          DropdownMenuItem<int>(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("2-Axis", style: TextStyle(color: Colors.white)),
                            ),
                            value: 4,
                          ),
                        ];
                      },
                    ),
                  ],
                ), onpress: () {  },
              ),
            ),
            Expanded(
              child: box(
                color: kMainColor,
                cardChild: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("Module Type", style: kLabelTextStyle, ),
                    DropdownButton<int>(
                      dropdownColor: kMainColor,
                      // isExpanded: true,
                      value: moduleType,
                      items: [
                        DropdownMenuItem(
                          child: Text("Standard", style: TextStyle(color: Colors.white),),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text("Premium", style: TextStyle(color: Colors.white),),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Thin Film", style: TextStyle(color: Colors.white),),
                          value: 2,
                        ),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          moduleType = value ?? 0; // use 0 as default value if value is null
                        });
                      },
                    ),
                  ],
                ), onpress: () {  },
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(24),),
        Align(
          alignment: Alignment.bottomCenter,
            child: lastButton(seen: 'Continue', onTapp: () {navigateToSolarOutput(context);}))
      ],
    );
  }

  void navigateToSolarOutput(BuildContext context) async {
    // Fetch the solar data using the LocationModel
    var solarData = await loc.getLocationSolarData(latitude, longitude, azi, sysCap, tilt, arrayType, moduleType, losses);
    print(solarData);
    if (solarData != null && solarData['outputs'] != null) {
      // Navigate to the SolarOutput screen and pass the solar data as arguments
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SolarOutput(
            ac_annual: solarData['outputs']['ac_annual'],
            solarRad_annual: solarData['outputs']['solrad_annual'],
            cap_factor: solarData['outputs']['capacity_factor'],
          ),
        ),
      );
    } else {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(title: Text('Invalid',));
      });
    }
  }
}