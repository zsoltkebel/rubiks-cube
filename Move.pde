class Move {
    float angle = 0.0;
    int x;
    int y;
    int z;
    int dir;
    boolean animating = false;
    boolean finished = false;

    Move(int x, int y, int z, int dir) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.dir = dir;
    }

    Move copy() {
        return new Move(x, y, z, dir);
    }

    void reverse() {
        dir *= -1;
    }

    void start() {
        animating = true;
        finished = false;
        this.angle = 0;
    }

    boolean finished() {
        return finished;
    }

    void update() {
        if (animating) {
            this.angle += dir * speed;
            if (abs(angle) > HALF_PI) {
                angle = 0;
                animating = false;
                finished = true;
                if (abs(z) > 0) {
                    turnZ(z, dir);
                } else if (abs(x) > 0) {
                    turnX(x, dir);
                } else if (abs(y) > 0) {
                    turnY(y, dir);
                }
            }
        }
    }
}