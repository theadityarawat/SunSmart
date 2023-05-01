import 'package:solar_saver/components/location.dart';
import 'package:solar_saver/components/networking.dart';
import 'package:geolocator/geolocator.dart';

const apiKey = 'dD8VRdUfgDiTEJzdX7BaXZMiNp15aIEB8nfi3dhM';
const locApiKey = 'pk.ce544ca3797558b3c4d838970d99400f';
const NREL_URL = 'https://developer.nrel.gov/api/pvwatts/v8.json';
const API_URL = 'https://us1.locationiq.com/v1/reverse';


class LocationModel {
  int s_capacity = 0;
  int m_type = 0;
  double s_losses = 0;
  int s_array_type = 0;
  int s_tilt = 0;
  int s_azimuth = 0;
  double lat=0;
  double lon=0;
  Future<dynamic> getLocationSolarData(double lat, double lon, int s_azimuth, int s_capacity, int s_tilt, int s_array_type, int m_type, double s_losses) async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        Uri.parse('$NREL_URL?api_key=${apiKey}&lat=${lat}&lon=${lon}&azimuth=${s_azimuth}&system_capacity=${s_capacity}&losses=${s_losses}&array_type=${s_array_type}&module_type=${m_type}&tilt=${s_tilt}'));

    var solarData = await networkHelper.getData();
    return solarData;
  }

  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        Uri.parse('$API_URL?lat=${location.latitude}&lon=${location.longitude}&key=$locApiKey&format=json'));
       //Uri.parse('https://us1.locationiq.com/v1/reverse?lat=28.1405741&lon=77.3259802&key=pk.ce544ca3797558b3c4d838970d99400f&format=json'));

    var locationData = await networkHelper.getData();
    print(locationData);
    return locationData;
  }
}
