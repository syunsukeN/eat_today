import 'dart:math' as math;

import 'package:eat_today/features/result/controller/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(restaurantSearchProvider).when(
            data: (data) {
              // ランダムに一つの飲食店を選択
              final randomIndex = math.Random().nextInt(data.length);
              final restaurant = data[randomIndex];
              // ユーザーがログインしている場合
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    restaurant.name,
                  ),
                  Text(
                    restaurant.formattedAddress,
                  ),
                  Text(
                    restaurant.geometry.toString(),
                  ),
                  Text(
                    restaurant.rating.toString(),
                  ),
                ],
              );
            },
            // エラーになった時
            error: (e, st) => ErrorPage(
              error: e.toString(),
            ),
            // ロード中
            loading: () => LoadingPage(),
          ),
    );
  }
}
