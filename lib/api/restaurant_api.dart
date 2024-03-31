import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../models/locations.dart';

final restaurantProvider = Provider((ref) {
  return ApiRestaurantService();
});

abstract class RestaurantRepository {
  Future<List<RepositoryDetail>> getRestaurant(
      double latitude, double longitude);
}

class ApiRestaurantService implements RestaurantRepository {
  final logger = Logger();

  final String apiKey = dotenv.env['apiKey'].toString();

  var dio = Dio(); // Dioのインスタンスを作成

  //
  @override
  Future<List<RepositoryDetail>> getRestaurant(
    double latitude,
    double longitude, {
    int radius = 1000, // デフォルト値を1000に設定
  }) async {
    try {
      Response response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
        queryParameters: {
          'query': '飲食店',
          'key': apiKey,
          'location': '${latitude},${longitude}',
          'radius': radius, // 検索半径をパラメータに追加
          'language': 'ja',
        },
      );

      final List<dynamic> items = response.data["results"];

      return items
          .map<RepositoryDetail>((itemMap) =>
              RepositoryDetail.fromJson(itemMap as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('Error: ${e.toString()}');
      return Future.error("飲食店情報の取得に失敗しました: ${e}");
    }
  }
}
