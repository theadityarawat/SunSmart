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

class LocationModel {
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
    return locationData;
  }

}
