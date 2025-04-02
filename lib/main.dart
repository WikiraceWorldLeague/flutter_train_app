import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // 디버그 배너 제거

      home:
          HomePage(), // 앱 실행 시 첫 화면을 HomePage로 설정
    );
  }
}
