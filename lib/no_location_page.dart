import 'package:flutter/material.dart';

class NoLocationPage extends StatelessWidget {
  const NoLocationPage({super.key});

  static const rootName = '/no-location'; // 名前付きルートで使うコンストラクターを定義しておく.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Center(child: Text("このアプリは位置情報がない場合は\nご利用いただけません!"))],
      ),
    );
  }
}
