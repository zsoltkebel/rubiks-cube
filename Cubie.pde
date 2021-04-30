final color BLACK = color(0, 0, 0);

class Cubie {
  PMatrix3D matrix;
  int x = 0;
  int y = 0;
  int z = 0;
  boolean highlight = false;
  // float angle = 0;
  PVector angle = new PVector();
  Face[] faces = new Face[6];
  
  Cubie(PMatrix3D m, int x, int y, int z) {
    this.matrix = m;
    this.x = x;
    this.y = y;
    this.z = z;

    faces[0] = new Face(new PVector(0, 0, -1), z == -1 ? color(0, 0, 255) : BLACK);
    faces[1] = new Face(new PVector(0, 0, 1), z == 1 ? color(0, 255, 0) : BLACK);
    faces[2] = new Face(new PVector(0, 1, 0), y == 1 ? color(255, 255, 255) : BLACK);
    faces[3] = new Face(new PVector(0, -1, 0), y == -1 ? color(255, 255, 0) : BLACK);
    faces[4] = new Face(new PVector(1, 0, 0), x == 1 ? color(255, 150, 0) : BLACK);
    faces[5] = new Face(new PVector(-1, 0, 0), x == -1 ? color(255, 0, 0) : BLACK);
  }
  
  void turnFacesZ(int dir) {
    for (Face f : faces) {
      f.turnZ(dir * HALF_PI);
    }
  }

  void turnFacesY(int dir) {
    for (Face f : faces) {
      f.turnY(dir * HALF_PI);
    }
  }

  void turnFacesX(int dir) {
    for (Face f : faces) {
      f.turnX(dir * HALF_PI);
    }
  }

  void update(int x, int y, int z) {
    this.matrix.reset();
    this.matrix.translate(x, y, z);
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void show() {
    // fill(255);
    noFill();
    if (highlight) {
      fill(255, 0, 0);
    }
    stroke(0);
    strokeWeight(0.1);
    pushMatrix();
    applyMatrix(matrix);
    // rotate(this.angle); // new bit
    rotateX(this.angle.x);
    rotateY(this.angle.y);
    rotateZ(this.angle.z);
    box(1);
    for (Face f : faces) f.show();
    //box(len);
    popMatrix();
  }
}
