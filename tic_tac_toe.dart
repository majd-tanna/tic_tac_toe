import 'dart:io';

void main() {
  while (true) {
    playGame();
    stdout.write("Do you want to play again? (y/n): ");
    String? answer = stdin.readLineSync();
    if (answer == null || answer.toLowerCase() != 'y') {
      print("Thanks for playing!");
      break;
    }
  }
}

void playGame() {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';
  int turn = 0;

  while (true) {
    showBoard(board);

    stdout.write("Player $currentPlayer, enter position (1-9): ");
    String? input = stdin.readLineSync();
    int? pos = int.tryParse(input ?? '');

    if (pos == null || pos < 1 || pos > 9 || board[pos - 1] != ' ') {
      print("Invalid move, try again.");
      continue;
    }

    board[pos - 1] = currentPlayer;
    turn++;

    if (checkWin(board, currentPlayer)) {
      showBoard(board);
      print("Player $currentPlayer wins!");
      break;
    }

    if (turn == 9) {
      showBoard(board);
      print("Draw!");
      break;
    }

    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }
}

void showBoard(List<String> board) {
  print("");
  for (int i = 0; i < 9; i += 3) {
    print("${board[i]} | ${board[i + 1]} | ${board[i + 2]}");
    if (i < 6) print("--+---+--");
  }
  print("");
}

bool checkWin(List<String> board, String player) {
  List<List<int>> winPositions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var pos in winPositions) {
    if (board[pos[0]] == player &&
        board[pos[1]] == player &&
        board[pos[2]] == player) {
      return true;
    }
  }
  return false;
}
