Gol gol;

void setup() {
  size(800, 600);
  gol = new Gol();
}

void draw() {
  background(0);
  gol.displayGrid();
  gol.displayMenu();
  gol.applyRules();
  gol.manualCells();
}

void mousePressed() {
  gol.menuButtons();
}
