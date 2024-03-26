import 'package:eat_today/controller/location_controller.dart';
import 'package:eat_today/no_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/error_page.dart';
import 'common/loading_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(currentUserLocationProvider).when(
            data: (position) {
              if (position != null) {
                // ユーザーがログインしている場合
                return Column(
                  children: [
                    Center(
                      child: Text(position.toString()),
                    )
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
