import 'package:flutter/material.dart';

class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  static const Map<int, String> bonusTiles = {
    0: '3W',
    7: '3W',
    14: '3W',
    105: '3W',
    119: '3W',
    210: '3W',
    217: '3W',
    224: '3W',
    16: '2W',
    28: '2W',
    32: '2W',
    96: '2W',
    112: '2W',
    128: '2W',
    160: '2W',
    192: '2W',
    20: '3L',
    24: '3L',
    76: '3L',
    80: '3L',
    84: '3L',
    88: '3L',
    136: '3L',
    140: '3L',
    144: '3L',
    148: '3L',
    200: '3L',
    204: '3L',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plansza gry')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 800,
              height: 800,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 15,
                ),
                itemCount: 15 * 15,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: bonusTiles.containsKey(index)
                          ? _getBonusColor(bonusTiles[index]!)
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        bonusTiles[index] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Text('A'),
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getBonusColor(String bonus) {
    switch (bonus) {
      case '3W':
        return Colors.redAccent;
      case '2W':
        return Colors.pinkAccent;
      case '3L':
        return Colors.blueAccent;
      case '2L':
        return Colors.lightBlueAccent;
      default:
        return Colors.white;
    }
  }
}
