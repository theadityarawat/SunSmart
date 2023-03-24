import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solar_saver/components/location.dart';
import 'package:solar_saver/components/networking.dart';

const apiKey = 'dD8VRdUfgDiTEJzdX7BaXZMiNp15aIEB8nfi3dhM';
const locApiKey = 'pk.ce544ca3797558b3c4d838970d99400f';
const NREL_URL = 'https://api.openweathermap.org/data/2.5/weather';
const API_URL= 'https://us1.locationiq.com/v1/reverse';
var ar;
class ApiNeed
{
  var s_capacity=0;
  var m_type=0;
  var s_losses=0;
  var s_array_type=0;
  var s_tilt=0;
  var s_azimuth=0;

}

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


class LocationBanner extends StatelessWidget {
  const LocationBanner({
    Key? key,
  }) : super(key: key);
  Future<dynamic> getLocationSolarData() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$NREL_URL?lat=${location.latitude}&lon=${location.longitude}&api_key=$apiKey&format=json&');

    var solarData = await networkHelper.getData();
    return solarData;
  }

  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$API_URL?lat=${location.latitude}&lon=${location.longitude}&key=$locApiKey&format=json');

    var locationData = await networkHelper.getData();
    // return locationData;
    ar=await getLocation();
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
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: "You're at\n"),
            TextSpan(
              text: '$ar',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
