import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool
  isDeparture; // 출발역인지 도착역인지 구분하는 변수 추가

  // 생성자 추가
  const StationListPage({
    Key? key,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            isDeparture ? '출발역 선택' : '도착역 선택',
          ),
        ),
      ),
      body: ListView(
        children: [
          stationTile(context, '수서'),
          stationTile(context, '동탄'),
          stationTile(context, '평택지제'),
          stationTile(context, '천안아산'),
          stationTile(context, '오송'),
          stationTile(context, '대전'),
          stationTile(context, '김천구미'),
          stationTile(context, '동대구'),
          stationTile(context, '경주'),
          stationTile(context, '울산'),
          stationTile(context, '부산'),
        ],
      ),
    );
  }

  // 선택한 역을 반환하는 위젯
  Widget stationTile(
    BuildContext context,
    String stationName,
  ) {
    return ListTile(
      title: Text(
        stationName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pop(
          context,
          stationName,
        ); // 선택한 역을 반환하여 HomePage로 전달
      },
    );
  }
}
