class Game { //<>// //<>// //<>// //<>//
  // egenskaber
  int w;
  int h;
  int numberOfEnemies;
  int numberOfHealth = 100; 
  int playerLife;
  int[] board[];
  Dot player;
  Dot player2;
  //Det skal være array da der skal være mere end en 
  Dot[] enemies;
  Dot[] health;



  Keys keys;

  // konstruktør
  Game(int gW, int gH, int nE, int nH) {
    w = gW;
    h = gH;
    numberOfEnemies = nE;
    numberOfHealth = nH; 
    enemies = new Dot[nE];
    health = new Dot[nH]; 
    playerLife=100; 
    board  = new int[gW][gH];
    player = new Dot(0, 1, w-1, h-1);
    player2 = new Dot(0, 5, w-1, h-1);
    keys = new Keys();

    for (int i = 0; i < nE; ++i) { 
      enemies[i] = new Dot(w-1, h-1, w-1, h-1);
    }
    for (int i = 0; i < nH; ++i) { 
      health[i] = new Dot(w-1, h-1, w-1, h-1);
    }
  }

  // metoder
  int[][] getBoard() { 
    return board;
  }

  public int getWidth() {
    return h;
  }

  public int getHeight() {
    return w;
  }

  int getPlayerLife() {
    return playerLife;
  }

  void onKeyPressed(char k) {
    keys.onKeyPressed(k);
  }
  void onKeyReleased(char k) {
    keys.onKeyReleased(k);
  }


  void update() {
    updatePlayer();
    //updateEnemies();
    updateHealth();
    checkForCollisions();
    gameOver();
    clearBoard();
    populateBoard();
  }

  void updatePlayer() {
    // tjekke om spilleren har trykket på a,s,d eller w
    if (keys.wDown) { 
      player.moveUp();
    }
    if (keys.aDown) {
      player.moveLeft();
    }
    // cond3 relateret til keypressed a
    if (keys.sDown) {
      player.moveDown();
    }
    if (keys.dDown) {
      player.moveRight();
    }

    // player 2
    if (keys.upDown) { 
      player2.moveUp();
    }
    if (keys.leftDown) {
      player2.moveLeft();
    }
    if (keys.downDown) {
      player2.moveDown();
    }
    if (keys.rightDown) {
      player2.moveRight();
    }
  }

  void updateEnemies() {
    // loope igennem alle fjender
    for (int i=0; i<enemies.length; i++) {
      // nogle gange skal fjende i følge efter spiller
      // andre gange flytte sig random

      if (i>=0) {
        int dX = player.xPos - enemies[i].xPos;
        int dY = player.yPos - enemies[i].yPos;
        if (dX>0) {
          //spilleren er til højre - så flyt mod højr
          enemies[i].moveRight();
        } else  if (dX<0) {
          enemies[i].moveLeft();
        } else if (dY>0) {
          //spilleren er til højre - så flyt mod højr
          enemies[i].moveDown();
        } else if (dY<0) {
          enemies[i].moveUp();
        }
      }
      int rand = (int) random(4);
      if (rand == 0) {
        enemies[i].moveUp();
      }
      if (rand == 1) {
        enemies[i].moveDown();
      }
      if (rand == 2) {
        enemies[i].moveRight();
      }
      if (rand == 3) {
        enemies[i].moveLeft();
      }
    }
  }

  void updateHealth() { 
    //loope igennem alle health
    for (int i=0; i<health.length; i++) {
      if (i>=0) {

        int dX = player.xPos - health[i].xPos;
        int dY = player.yPos - health[i].yPos;
        if (dX<0) {
          //spilleren er til højre - så flyt mod højre
          health[i].moveRight();
        } else  if (dX>0) {
          health[i].moveLeft();
        } else if (dY<0) {
          //spilleren er til højre - så flyt mod højre
          health[i].moveDown();
        } else if (dY>0) {
          health[i].moveUp();
        }
      }
      //rand = random
      int rand = (int) random(4);
      if (rand == 0) {
        health[i].moveUp();
      }
      if (rand == 1) {
        health[i].moveDown();
      }
      if (rand == 2) {
        health[i].moveRight();
      }
      if (rand == 3) {
        health[i].moveLeft();
      }
    }
  }

  void checkForCollisions() {
    // dvs hvis der er 1 i feltet og 2 er samme sted har vi koll
    // spør hver fjende er du samme sted som player?
    for (int i=0; i<enemies.length; i++) {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY()) {
        // then coll and player looses one lifepoint
        if (playerLife>0) //fortsætter ikke efter 0
        {
          playerLife--; //falder i liv
        }
      }
    }
    // check for collisions between player and healthnodes
    for (int i=0; i<health.length; i++) {
      if (health[i].getX() == player.getX() && health[i].getY() == player.getY()) {
        // to make sure our player doesnt exceed 100 hitpoints
        if (playerLife<100) 
        {
          playerLife++;
        }
        // when colliding with healthnodes, remove them 
        removeHealth(health, i);
        // and then spawn them back
        addHealth(health);
      }
    }
  }

  // checks if our player goes below 0 hitpoints and ends the game
  boolean gameOver() {
    if (playerLife == 0) {
      delay(1);
      noLoop();
      return(true);
    }
    return false;
  }

  // resets the grid when its been used
  void clearBoard() {
    for (int y = 0; y < h; ++y) {
      for (int x = 0; x < w; ++x) {
        board[x][y]=0;
      }
    }
  }

  void populateBoard() {
    // spawn our player
    board[player.getX()][player.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    // spawn our enemies
    for (int i = 0; i < enemies.length; ++i) {
      board[enemies[i].getX()][enemies[i].getY()]= 2;
    }
    // spawn health nodes
    for (int i = 0; i < health.length; ++i) {
      board[health[i].getX()][health[i].getY()]= 3;
    }
  }

  // when hitting a health node, remove it
  void removeHealth(Dot[] array, int index) {
    int index2 = array.length-1;
    Dot old = array[index];
    array[index] = array[index2];
    array[index2] = old;
    array = (Dot[])shorten(array);
  }


  // and then spawn it back
  void addHealth(Dot[] array) {
    array = (Dot[])expand(array);
    array[array.length-1] = new Dot(w-1, h-1, w-1, h-1);
  }
}
