import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/stations/station_list_page.dart';
import 'package:flutter_train_app/pages/seats/seat_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  // 출발역 선택 후 도착역 선택
  Future<void> selectStation(
    bool isDeparture,
  ) async {
    final selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => StationListPage(
              isDeparture: isDeparture,
            ),
      ),
    );

    // selectedStation이 null이 아닐 경우에만 상태 변경
    if (selectedStation != null &&
        selectedStation is String) {
      setState(() {
        if (isDeparture) {
          departureStation = selectedStation;
          arrivalStation =
              null; // 출발역이 변경되면 도착역 초기화
        } else {
          arrivalStation = selectedStation;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Center(child: Text('기차 예매')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Spacer(),

            // 출발역 & 도착역 선택 카드
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // 세로 중앙 정렬
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .center, // 가로 중앙 정렬
                      children: [
                        Text(
                          '출발역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            departureStation ??
                                "선택",
                            style:
                                const TextStyle(
                                  fontSize: 40,
                                ),
                            textAlign:
                                TextAlign.center,
                          ),
                          onTap:
                              () => selectStation(
                                true,
                              ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 2,
                    height: 50,
                    color:
                        Colors
                            .grey[400], // 세로 구분선
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // 세로 중앙 정렬
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .center, // 가로 중앙 정렬
                      children: [
                        Text(
                          '도착역',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            arrivalStation ??
                                "선택",
                            style:
                                const TextStyle(
                                  fontSize: 40,
                                ),
                            textAlign:
                                TextAlign.center,
                          ),
                          onTap:
                              departureStation !=
                                      null
                                  ? () =>
                                      selectStation(
                                        false,
                                      )
                                  : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40), // 간격 조정
            // 좌석 선택 버튼 (출발역, 도착역 선택 후 활성화)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed:
                    (departureStation != null &&
                            arrivalStation !=
                                null)
                        ? () {
                          if (departureStation !=
                                  null &&
                              arrivalStation !=
                                  null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (
                                      context,
                                    ) => SeatPage(
                                      departure:
                                          departureStation!,
                                      arrival:
                                          arrivalStation!,
                                    ),
                              ),
                            );
                          }
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  disabledBackgroundColor:
                      Colors.purple,
                ),
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
