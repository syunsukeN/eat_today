// location_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eat_today/models/location_service.dart';

// LocationServiceのインスタンスを提供するProvider
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

// 現在のユーザー位置情報を取得するFutureProvider
final currentUserLocationProvider = FutureProvider<Position?>((ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getCurrentLocation();
});
