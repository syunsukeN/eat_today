import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final currentLocationProvider = Provider((ref) {
  return LocationService();
});

abstract class CurrentLocation {
  Future<Position?> getCurrentLocation();

  Point<double> generateRandomPoint(
      double latitude, double longitude, int maxRadius);
}

class LocationService implements CurrentLocation {
  // ユーザーの現在地を取得することができる。
  @override
  Future<Position?> getCurrentLocation() async {
    try {
      // 位置情報のリクエストを送る
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      throw e;
    }
  }

// 現在位置（latitude, longitude）と最大半径（maxRadius）を基にランダムな点を生成
  @override
  Point<double> generateRandomPoint(
      double latitude, double longitude, int maxRadius) {
    Random random = Random();
    double distance = random.nextDouble() * maxRadius; // 0からmaxRadiusの間でランダムな距離
    double angle = random.nextDouble() * 2 * pi; // 0から360度（ラジアンで2π）の間でランダムな角度

    // 簡単化のための計算（実際には球面距離を考慮した計算が必要）
    double deltaLatitude = distance * cos(angle) / 111.0; // 緯度の変化
    double deltaLongitude =
        distance * sin(angle) / (111.0 * cos(latitude * (pi / 180))); // 経度の変化

    return Point(latitude + deltaLatitude, longitude + deltaLongitude);
  }
}
