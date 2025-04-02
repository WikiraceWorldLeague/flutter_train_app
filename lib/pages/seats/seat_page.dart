import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({
    Key? key,
    required this.departure,
    required this.arrival,
  }) : super(key: key);

  @override
  State<SeatPage> createState() =>
      _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<bool>> selectedSeats = List.generate(
    20,
    (_) => List.generate(4, (_) => false),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  widget.departure,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(width: 50),
                const Icon(
                  Icons
                      .arrow_circle_right_outlined,
                  size: 30,
                ),
                const SizedBox(width: 50),
                Text(
                  widget.arrival,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius:
                            BorderRadius.circular(
                              8,
                            ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text("선택됨"),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(
                              8,
                            ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text("선택안됨"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: const [
                Text(
                  "A",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 50),
                Text(
                  "B",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 50),
                SizedBox(width: 50),
                Text(
                  "C",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 50),
                Text(
                  "D",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, row) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        ...List.generate(2, (
                          col,
                        ) {
                          return seatButton(
                            row,
                            col,
                          );
                        }),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                          child: Container(
                            width: 50,
                            height: 50,
                            alignment:
                                Alignment.center,
                            child: Text(
                              '${row + 1}',
                              style:
                                  const TextStyle(
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        ),
                        ...List.generate(2, (
                          col,
                        ) {
                          return seatButton(
                            row,
                            col + 2,
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (widget
                          .departure
                          .isNotEmpty &&
                      widget.arrival.isNotEmpty) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            '예매하시겠습니까?',
                          ),
                          content: Text(
                            _formatSelectedSeats(),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction:
                                  true,
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pop();
                              },
                              child: Text('취소'),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction:
                                  true,
                              onPressed: () {},
                              child: Text('확인'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "예매 하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget seatButton(int row, int col) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSeats[row][col] =
                !selectedSeats[row][col];
          });
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color:
                selectedSeats[row][col]
                    ? Colors.purple
                    : Colors.grey[300],
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
        ),
      ),
    );
  }

  String _formatSelectedSeats() {
    final seats = [];
    for (
      int row = 0;
      row < selectedSeats.length;
      row++
    ) {
      for (
        int col = 0;
        col < selectedSeats[row].length;
        col++
      ) {
        if (selectedSeats[row][col]) {
          final seatLabel = String.fromCharCode(
            'A'.codeUnitAt(0) + col,
          );
          seats.add('$seatLabel${row + 1}');
        }
      }
    }
    return seats.join(', ');
  }
}
