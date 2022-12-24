//shape patterns from http://game-of-life.daneaiulian.com/patterns

class PredefinedShape {
  int selectedShape;
  int sx;
  int sy;

  PredefinedShape(int s, int x, int y) {

    selectedShape = s;
    sx = x;
    sy = y;
  }

  void placeShape() {
    if (selectedShape == 1) {
      shape1();
    }

    if (selectedShape == 2) {
      shape2();
    }

    if (selectedShape == 3) {
      shape3();
    }

    if (selectedShape == 4) {
      shape4();
    }
    
    if (selectedShape == 5) {
      shape5();
    }
  }

  void shape1() {
    //block
    gol.cells[sx][sy] = 1;
    gol.cells[sx+1][sy] = 1;
    gol.cells[sx][sy+1] = 1;
    gol.cells[sx+1][sy+1] = 1;
  }

  void shape2() {
    //glider
    gol.cells[sx+1][sy] = 1;
    gol.cells[sx+2][sy+1] = 1;
    gol.cells[sx][sy+2] = 1;
    gol.cells[sx+1][sy+2] = 1;
    gol.cells[sx+2][sy+2] = 1;
  }

  void shape3() {
    //toad
    gol.cells[sx+1][sy] = 1;
    gol.cells[sx+2][sy] = 1;
    gol.cells[sx+3][sy] = 1;
    gol.cells[sx][sy+1] = 1;
    gol.cells[sx+1][sy+1] = 1;
    gol.cells[sx+2][sy+1] = 1;
  }

  void shape4() {
    //glider by the dozen
    gol.cells[sx][sy] = 1;
    gol.cells[sx+1][sy] = 1;
    gol.cells[sx+4][sy] = 1;
    gol.cells[sx][sy+1] = 1;
    gol.cells[sx+4][sy+1] = 1;
    gol.cells[sx][sy+2] = 1;
    gol.cells[sx+3][sy+2] = 1;
    gol.cells[sx+4][sy+2] = 1;
  }

  void shape5() {
    ///diehard
    gol.cells[sx+6][sy] = 1;
    gol.cells[sx][sy+1] = 1;
    gol.cells[sx+1][sy+1] = 1;
    gol.cells[sx+1][sy+2] = 1;
    gol.cells[sx+5][sy+2] = 1;
    gol.cells[sx+6][sy+2] = 1;
    gol.cells[sx+7][sy+2] = 1;
  }
}
