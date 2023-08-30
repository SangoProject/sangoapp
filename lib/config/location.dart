import 'package:geolocator/geolocator.dart';

Future<Position?> getLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    return position;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}


// import 'package:location/location.dart';
//
// Future<LocationData?> getLocation() async {
//   Location location = Location();
//   bool _serviceEnabled = false;
//   PermissionStatus _permissionGranted = PermissionStatus.denied;
//
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return null;
//     }
//   }
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return null;
//     }
//   }
//
//   try {
//     final LocationData res = await location.getLocation();
//     print('Latitude: ${res.latitude}, Longitude: ${res.longitude}');
//     return res;
//   } catch (e) {
//     print('Error: $e');
//     return null;
//   }
// }
