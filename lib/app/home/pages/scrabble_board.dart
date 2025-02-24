import 'package:flutter/material.dart';

class ScrabbleBoard extends StatelessWidget {
  final List<List<Tile>> board;

  const ScrabbleBoard({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 15,
      ),
      itemCount: 15 * 15,
      itemBuilder: (context, index) {
        int row = index ~/ 15;
        int col = index % 15;
        Tile tile = board[row][col];

        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: tile.multiplier == 1
                ? Colors.brown[200]
                : tile.multiplier == 2
                    ? Colors.blue[300]
                    : Colors.red[300],
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              tile.letter,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

class Tile {
  final String letter;
  final int multiplier; // 1 = normal, 2 = double letter, 3 = triple word

  Tile({this.letter = '', this.multiplier = 1});
}

List<List<Tile>> board = List.generate(
  15,
  (_) => List.generate(15, (_) => Tile(), growable: false),
  growable: false,
);
