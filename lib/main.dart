import 'package:eat_today/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter, // このコードを追加すると画面遷移ができるようになる.
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // home: ref.watch(currentUserLocationProvider).when(
      //       data: (position) {
      //         if (position != null) {
      //           // ユーザーがログインしている場合
      //           return const HomePage();
      //         }
      //         // ユーザーがログインしていない場合
      //         return NoLocationPage();
      //       },
      //       // エラーになった時
      //       error: (e, st) => ErrorPage(
      //         error: e.toString(),
      //       ),
      //       // ロード中
      //       loading: () => LoadingPage(),
      //     ),
    );
  }
}
