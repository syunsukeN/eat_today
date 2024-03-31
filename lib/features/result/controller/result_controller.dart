// 現在地からその付近の飲食店情報を取得する
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/restaurant_api.dart';
import '../../../models/locations.dart';
import '../../home/controller/location_controller.dart';

final restaurantSearchProvider =
    FutureProvider<List<RepositoryDetail>>((ref) async {
  // LocationServiceのインスタンスを取得
  final locationService = ref.read(locationServiceProvider);

  // 現在のユーザー位置情報を取得
  final currentPosition = await ref.watch(currentUserLocationProvider.future);

  // 指定された半径を取得
  final radius = ref.watch(sliderValueProvider);

  // 位置情報がnullでない場合にのみ、飲食店を検索を実行
  if (currentPosition != null) {
    final latitude = currentPosition.latitude;
    final longitude = currentPosition.longitude;

    // ランダムな地点を生成
    final randomPoint =
        locationService.generateRandomPoint(latitude, longitude, radius);

    // restaurantProviderが正しく実装されている必要がある
    final restaurantApi = ref.watch(restaurantProvider);

    // ランダムに生成された地点から飲食店情報を取得
    return await restaurantApi.getRestaurant(randomPoint.x, randomPoint.y,
        radius: radius);
  }
  return Future.error("飲食店情報の取得に失敗しました");
});
