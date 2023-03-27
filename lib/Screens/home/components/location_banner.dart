import 'package:flutter/material.dart';
import 'package:solar_saver/components/location_model.dart';
import '../../../size_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solar_saver/components/location.dart';
import 'package:solar_saver/components/networking.dart';



Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


class LocationBanner extends StatefulWidget {
  LocationBanner({this.locationData});
  final locationData;

  @override
  State<LocationBanner> createState() => _LocationBannerState();
}

class _LocationBannerState extends State<LocationBanner> {
  LocationModel loc = LocationModel();
 String cityName='';

 @override
  void initState(){
  super.initState();

  updateUI(widget.locationData);
 }

  void updateUI(dynamic locationCity) {
    setState(() {
      if (locationCity == null) {
        cityName = '';
        return;
      }
      cityName = locationCity['address']['county'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
          child:TextButton(onPressed:() async {
          var locationCity = await loc.getLocation();
          updateUI(locationCity);
          }, child: Icon(Icons.ac_unit)
          )),
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: "You're at\n"),
                TextSpan(
                  text: '$cityName',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
