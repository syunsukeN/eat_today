import 'package:eat_today/no_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../controller/location_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(sliderValueProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("今日はどこで外食する？"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('${ref.watch(sliderValueProvider).toString()}km 圏内'),
              onTap: () {
                // アイテムがタップされたときの処理
              },
            ),
            // Sliderを配置
            Slider(
              value: sliderValue.toDouble(),
              min: 1.0,
              max: 100.0,
              divisions: 99,
              // 1から100までの100個の値に分割
              label: '${sliderValue.round()}',
              onChanged: (newValue) {
                // スライダーの値が既に10の倍数なので、そのまま使用する
                ref.read(sliderValueProvider.notifier).state = newValue.toInt();
              },
            )
          ],
        ),
      ),
      body: ref.watch(currentUserLocationProvider).when(
            data: (position) {
              if (position != null) {
                // ユーザーがログインしている場合
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '${ref.watch(sliderValueProvider).toString()}km 圏内',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(position.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.push('/restaurant');
                        },
                        child: Text("検索"))
                  ],
                );
              }
              // ユーザーがログインしていない場合
              return NoLocationPage();
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
