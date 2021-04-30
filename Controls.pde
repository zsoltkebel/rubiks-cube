void keyPressed() {
    currentMove.start();
    // applyMove(key);
}

void applyMove(char move) {
  switch (move) {
    case 'f':
        currentMove = allMoves[8];
        currentMove.start();
        break;
    case 'F':
        turnZ(1, -1);
        break;
    case 'b':
        currentMove = allMoves[10];
        currentMove.start();
        break;
    case 'B':
        turnZ(-1, -1);
        break;
    case 'u':
        turnY(1, 1);
        break;
    case 'U':
        turnY(1, -1);
        break;
    case 'd':
        turnY(-1, -1);
        break;	
    case 'D':
        turnY(-1, 1);
        break;
    case 'l' :
        turnX(-1, 1);
        break;
    case 'L':
        turnX(-1, -1);
        break;
    case 'r':
        turnX(1, 1);
        break;
    case 'R':
        turnX(1, -1);
        break;
  }
}
