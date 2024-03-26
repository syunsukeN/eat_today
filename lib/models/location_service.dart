import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final currentLocationProvider = Provider((ref) {
  return LocationService();
});

abstract class CurrentLocation {
  Future<Position?> getCurrentLocation();
}

class LocationService implements CurrentLocation {
  // ユーザーの現在地を取得することができる。
  @override
  Future<Position?> getCurrentLocation() async {
    // try {
    // 位置情報のリクエストを送る
    // await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
    // } catch (e) {
    //   throw e;
    // }
  }
}
