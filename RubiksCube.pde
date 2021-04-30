import peasy.*;

PeasyCam cam;

float speed = 0.5;
int dim = 3;
Cubie[] cube = new Cubie[dim*dim*dim];

Move[] allMoves = new Move[] {
  new Move(0, 1, 0, 1),     // DOWN
  new Move(0, 1, 0, -1),    // DOWN anti
  new Move(0, -1, 0, 1),    // UP
  new Move(0, -1, 0, -1),   // UP anti
  new Move(1, 0, 0, 1),     // RIGHT
  new Move(1, 0, 0, -1),    // RIGHT anti
  new Move(-1, 0, 0, 1),    // LEFT
  new Move(-1, 0, 0, -1),   // LEFT anti
  new Move(0, 0, 1, 1),     // FRONT
  new Move(0, 0, 1, -1),    // FRONT anti
  new Move(0, 0, -1, 1),    // BACK
  new Move(0, 0, -1, -1),   // BACK anti
};
ArrayList<Move> sequence = new ArrayList<Move>();
int counter = 0;

Move currentMove;

void setup() {
  size(600, 600, P3D);
  // fullScreen(P3D);
  cam = new PeasyCam(this, 400);
  int index = 0;
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cube[index] = new Cubie(matrix, x, y, z);
        index++;
      }
    }
  }
  
  // initiating the sequence of moves
  for(int i = 0; i < 50; i++) {
    int r = int(random(allMoves.length));
    Move m = allMoves[r];
    sequence.add(m);
  }

  currentMove = sequence.get(counter);

  for (int i = sequence.size() - 1; i >= 0; i--) {
    Move nextMove = sequence.get(i).copy();
    nextMove.reverse();
    sequence.add(nextMove);
  }

  println(sequence);
}

void draw() {
  background(51);

  fill(255);
  textSize(32);
  text(counter, 100, 100);

  currentMove.update();
  if (currentMove.finished()) {
    if (counter < sequence.size() - 1) {
      counter++;
      currentMove = sequence.get(counter);
      currentMove.start();
    }
  }

  // if (counter < sequence.length()) {
  //   char move = sequence.charAt(counter);
  //   applyMove(move);
  //   counter++;
  // }

  scale(50);
  for (int i = 0; i < cube.length; i++) {
    push();
    if (abs(cube[i].z) > 0 && cube[i].z == currentMove.z) {
        rotateZ(currentMove.angle);
    } else if (abs(cube[i].x) > 0 && cube[i].x == currentMove.x) {
        rotateX(currentMove.angle);
    } else if (abs(cube[i].y) > 0 && cube[i].y == currentMove.y) {
        rotateY(-currentMove.angle);
    }
    cube[i].show();
    pop();
  }
}

void turnZ(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubie qb = cube[i];
    if (qb.z == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.x, qb.y);
      
      float x = matrix.m02;
      float y = matrix.m12;
      float z = qb.z;
      qb.update(round(x), round(y), round(z));  
      qb.turnFacesZ(dir);
    }
  }
}

void turnY(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubie qb = cube[i];
    if (qb.y == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.x, qb.z);
      
      float x = matrix.m02;
      float y = qb.y;
      float z = matrix.m12;
      qb.update(round(x), round(y), round(z));
      qb.turnFacesY(dir);
    }
  }
}

void turnX(int index, int dir) {
  for (int i = 0; i < cube.length; i++) {
    Cubie qb = cube[i];
    if (qb.x == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.y, qb.z);
      
      float x = qb.x;
      float y = matrix.m02;
      float z = matrix.m12;
      qb.update(round(x), round(y), round(z));
      qb.turnFacesX(dir);
    }
  }
}