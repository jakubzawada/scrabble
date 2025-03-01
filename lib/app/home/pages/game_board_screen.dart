import 'dart:math';
import 'package:flutter/material.dart';

class GameBoardScreen extends StatefulWidget {
  const GameBoardScreen({super.key});

  @override
  GameBoardScreenState createState() => GameBoardScreenState();
}

class GameBoardScreenState extends State<GameBoardScreen> {
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

  final Map<String, int> letterDistribution = {
    'A': 9,
    'B': 2,
    'C': 2,
    'D': 4,
    'E': 12,
    'F': 2,
    'G': 3,
    'H': 2,
    'I': 9,
    'J': 1,
    'K': 1,
    'L': 4,
    'M': 2,
    'N': 6,
    'O': 8,
    'P': 2,
    'Q': 1,
    'R': 6,
    'S': 4,
    'T': 6,
    'U': 4,
    'V': 2,
    'W': 2,
    'X': 1,
    'Y': 2,
    'Z': 1,
    '_': 2
  };

  List<String> letterRack = [];
  Map<int, String?> boardState = {};

  @override
  void initState() {
    super.initState();
    _generateRandomLetters();
  }

  // Funkcja do losowania liter
  void _generateRandomLetters() {
    final random = Random();
    final availableLetters = <String>[];

    // Tworzymy listę liter, uwzględniając ich liczbę
    letterDistribution.forEach((letter, count) {
      availableLetters.addAll(List.filled(count, letter));
    });

    setState(() {
      letterRack = List.generate(7, (_) {
        final randomIndex = random.nextInt(availableLetters.length);
        return availableLetters.removeAt(randomIndex);
      });
    });
  }

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
                  return DragTarget<String>(
                    onAccept: (letter) {
                      setState(() {
                        boardState[index] = letter;
                        letterRack.remove(letter);
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: bonusTiles.containsKey(index)
                              ? _getBonusColor(bonusTiles[index]!)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            boardState[index] ?? (bonusTiles[index] ?? ''),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: letterRack.map((letter) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Draggable<String>(
                      data: letter,
                      feedback: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.amber.shade200,
                          ),
                          child: Center(
                            child: Text(letter,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      childWhenDragging: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey.shade300,
                        ),
                        child: const Center(child: Text('')),
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.amber,
                        ),
                        child: Center(
                          child: Text(letter),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
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
