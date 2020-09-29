class Keys {
  //egenskaber
  private boolean wDown = false; 
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;

  private boolean upDown = false; 
  private boolean leftDown = false;
  private boolean downDown = false;
  private boolean rightDown = false;

  // konstruktør
  Keys() {
  }
  // metoder
  //Når du klikker bliver den true
  void onKeyPressed(char k) {
    if (k=='a' || k=='A') {
      aDown=true;
    }
    if (k=='s' || k=='S') {
      sDown=true;
    }
    if (k=='w' || k=='W') {
      wDown=true;
    }
    if (k=='d' || k=='D') {
      dDown=true;
    }

    // arrow keys
    if (keyCode == CODED || keyCode == LEFT) {
      leftDown=true;
    }
    if (keyCode == CODED || keyCode == DOWN) {
      downDown=true;
    }
    if (keyCode == CODED || keyCode == UP) {
      upDown=true;
    }
    if (keyCode == CODED || keyCode == RIGHT) {
      rightDown=true;
    }
  }

  //Når du slipper bliver den false
  void onKeyReleased(char k) {
    if (k=='a' || k=='A') {
      aDown=false;
    }
    if (k=='s' || k=='S') {
      sDown=false;
    }
    if (k=='w' || k=='W') {
      wDown=false;
    }
    if (k=='d' || k=='D') {
      dDown=false;
    }

    // arrow keys    
    if (keyCode == CODED || keyCode == LEFT) {
      leftDown=false;
    }
    if (keyCode == CODED || keyCode == DOWN) {
      downDown=false;
    }
    if (keyCode == CODED || keyCode == UP) {
      upDown=false;
    }
    if (keyCode == CODED || keyCode == RIGHT) {
      rightDown=false;
    }
  }
}
