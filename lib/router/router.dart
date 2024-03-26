import 'package:eat_today/home_page.dart';
import 'package:eat_today/no_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    // アプリが起動した時
    initialLocation: '/',
    // メインページ
    routes: [
      GoRoute(
        path: '/',
        name: 'initial',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
      ),
      // 現在地が取得できなかった時
      GoRoute(
        path: '/no-location',
        name: 'no-location',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const NoLocationPage(),
          );
        },
      ),
    ],
    // 遷移ページがないなどのエラーが発生した時に、このページに行く
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );
});
