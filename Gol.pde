//concepts for game of life rule implementation adapted from https://processing.org/examples/gameoflife.html

class Gol {
  int cellSize = 10;
  int alive = (255);
  int dead = (0);

  int[][] cells; 
  int[][] saveCells; 

  boolean paused = true;

  int selectedShape;
  ArrayList <PredefinedShape> pList;

  int updateTime = 70;
  int recordTime;

  Gol() {
    cells = new int[width+10/cellSize][height/cellSize]; //+10 to prevent out of bounds when shapes are placed on edge
    saveCells = new int[width/cellSize][height/cellSize];
    pList = new ArrayList <PredefinedShape>();
  }

  void displayGrid() {
    
    //draw grid
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<(height-130)/cellSize; y++) { //-130 for button interface

        if (cells[x][y]==1) {
          fill(alive);
        } else {
          fill(dead);
        }
        strokeWeight(1);
        stroke(70);
        rect (x*cellSize, y*cellSize, cellSize, cellSize);
      }
    }
  }

  void displayMenu() {

    //draw start/stop, clear and randomize and buttons
    for (int i=0; i<3; i++) {
      int shade = 0; 
      if (mouseX >50 && mouseX < 140 && mouseY > i*30+511 && mouseY < i*30+511+18) {
        shade = 90;
      }
      fill(shade);
      stroke(255);
      strokeWeight(2);
      rect(50, i*30+511, 90, 18, 7);
    }

    fill(255);
    textSize(16);

    if (paused) {
      text("Start", 77, 526);
    } else if (!paused) {
      text("Stop", 78, 526);
    }
    text("Clear", 76, 556);
    text("Random", 64, 586);


    //manually place cells button
    int shade2 = 0;
    if (mouseX >640 && mouseX < 740 && mouseY > 483 && mouseY < 501 || selectedShape == 0) {
      shade2 = 90;
    }
    fill(shade2);
    stroke(255);
    strokeWeight(2);
    rect(640, 483, 100, 18, 7);

    fill(255);
    text("Manual", 665, 497);


    //pre-defined shapes interface
    for (int i=0; i<5; i++) {
      int shade = 0;
      if (mouseX >i*120+160 && mouseX < i*120+160+100 && mouseY > 515 && mouseY < 585 || selectedShape == i+1) {
        shade = 90;
      }
      fill(shade);
      stroke(255);
      strokeWeight(2);
      rect(i*120+160, 515, 100, 70, 7);
    }

    fill(255);

    textSize(21);
    text("Pre-Defined Shapes:", 300, 500); 

    textSize(18);
    text("Block", 185, 556);
    text("Glider", 305, 556);
    text("Toad", 428, 556);
    text("Diehard", 658, 556); 

    textSize(16);
    text("Glider by", 535, 540);
    text("the Dozen", 530, 565);
  }


  void menuButtons() {
    //start/stop button
    if (mouseX >50 && mouseX < 140 && mouseY > 0*30+511 && mouseY < 0*30+511+18) {
      pause();
    }

    //clear button
    if (mouseX >50 && mouseX < 140 && mouseY > 1*30+511 && mouseY < 1*30+511+18) {
      clearScreen();
    }

    //randomize cells button
    if (mouseX >50 && mouseX < 140 && mouseY > 2*30+511 && mouseY < 2*30+511+18) {
      randomCells();
    }

    //manual cell button
    if (mouseX >640 && mouseX < 740 && mouseY > 483 && mouseY < 501) {
      selectedShape = 0;
    }

    //predefined shape selector
    for (int i=0; i<5; i++) {
      if (mouseX >i*120+160 && mouseX < i*120+160+100 && mouseY > 515 && mouseY < 585) {
        selectedShape = i+1;
      }

      if (paused && selectedShape > 0) {
        for (int x=0; x<(width+10)/cellSize; x++) {
          for (int y=0; y<(height-130)/cellSize; y++) {

            if (mouseX > x*cellSize && mouseX < x*cellSize+cellSize && mouseY > y*cellSize && mouseY < y*cellSize+cellSize) {

              //create new selected shape object where clicked
              PredefinedShape p = new PredefinedShape(selectedShape, x, y);
              pList.add(p);
              p.placeShape();
            }
          }
        }
      }
    }
  }


  //cell functions:


  void randomCells() {
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<(height-130)/cellSize; y++) {

        float state = random(100);

        if (state > 17) { //17% chance of alive start
          state = 0;
        } else {
          state = 1;
        }
        cells[x][y] = int(state);
      }
    }
  }


  void clearScreen() {
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y] = 0; //make all cells dead
      }
    }
    paused = true; //pause after clearing
  }


  void pause() {
    if (paused) {
      paused = false;
    } else if (!paused) {
      paused = true;
    }
  }


  void manualCells() {

    if (paused && selectedShape == 0 && mousePressed) {

      for (int x=0; x<width/cellSize; x++) {
        for (int y=0; y<(height-130)/cellSize; y++) {

          //if selected cell is dead, make it alive
          if (mouseX > x*cellSize && mouseX < x*cellSize+cellSize && mouseY > y*cellSize && mouseY < y*cellSize+cellSize && cells[x][y]==0) {
            int state = 1;
            cells[x][y] = state;
          }
        }
      }
    }
  }


  void applyRules() { 

    //slow down cell updates
    if (updateTime < millis() - recordTime) {
      recordTime = millis();  

      for (int x=0; x<width/cellSize; x++) {
        for (int y=0; y<height/cellSize; y++) {

          // Save cells to second array so main array can be updated
          saveCells[x][y] = cells[x][y];
        }
      }

      for (int x=0; x<width/cellSize; x++) {
        for (int y=0; y<height/cellSize; y++) {

          //count each cell's neighbours
          int neighbours = 0; 

          for (int nx=x-1; nx<=x+1; nx++) {
            for (int ny=y-1; ny<=y+1; ny++) {  
              if (((nx>=0) && (nx<width/cellSize)) && ((ny>=0) && (ny<height/cellSize)) && (!((nx==x)&&(ny==y)))) { //prevent checking out of bounds and self
                if (saveCells[nx][ny]==1) {
                  neighbours ++; //add up all of the cells that are alive
                }
              }
            }
          }

          if (!paused) {

            //GAME OF LIFE RULES:

            //1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
            //2. Any live cell with two or three live neighbours lives on to the next generation.
            //3. Any live cell with more than three live neighbours dies, as if by overpopulation.

            if (saveCells[x][y]==1 && (neighbours < 2 || neighbours > 3)) {
              cells[x][y] = 0;
            } 

            //4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction. 

            else if (neighbours == 3 ) {
              cells[x][y] = 1;
            }
          }
        }
      }
    }
  }
}
