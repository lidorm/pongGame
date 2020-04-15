
// Screens types
// 0: Click to start
// 1: Game screen
// 2: Game Over screen
int screenType = 0; 
// Ball and Players creation
Ball ball = new Ball(300,200,30,30);
Player player1 = new Player(20,150,20,100);
Player player2 = new Player(560,220,20,100);

void setup(){
  size(600,400);  
}

void draw(){
  // Check and display the currect screen
  if(screenType == 0){
    startScreen();
  } else if (screenType == 1){
    gameScreen();
  }else if (screenType == 2) {
    gameOverScreen();
  }
}


void startScreen(){
  background(0, 200, 0);
  textAlign(CENTER);
  textSize(32);
  text("Click to start", width / 2 - 10, 200);
}
 
void gameScreen(){
  
  background(0, 200, 0);
  noFill();
  line(300, 0, 300, height);
  ellipse(300, 200, 90, 90);
  stroke(0);
  fill(255);
  player1.drawPlayer();
  player2.drawPlayer();
  ball.drawBall();
  stroke(255);
  
  ball.ballMovement();
  player1.playerMovement();
  player2.playerMovement();

  
}

void gameOverScreen(){
  textSize(68);
  textAlign(CENTER);
  text("GAME OVER!", (width / 2), 100);
  textSize(32);
  text("Click to restart", width / 2 - 10, 300);
  screenType = 2;
}

class Player {
  int x; // X Corodinate
  int y; // Y Coordinate
  int w; // Width
  int h; // Height
  int playerSpeed; // movement speed of each player
  
  public Player(int xc,int yc, int w, int h){
    this.x = xc;
    this.y = yc;
    this.w = w;
    this.h = h;
    this.playerSpeed = 4;
  }
  
  void drawPlayer(){
    rect(this.x,this.y,this.w,this.h);
  }
  
  void playerMovement(){
    
    // Player movement
    // Player2
    if(keyPressed){
    if (keyCode == DOWN) {
      if (player2.y < height - 100) {
        player2.y = player2.y + playerSpeed;
      }
    }
    // Player1
    if (keyCode == SHIFT) {
      if (player1.y > 0) {
        player1.y = player1.y - playerSpeed;
      }
    }
    // Player2
    if (keyCode == UP) {
      if (player2.y > 0) {
        player2.y = player2.y - playerSpeed;
      }
    }
    // Player1
    if (keyCode == CONTROL) {
      if (player1.y < height - 100) {
        player1.y = player1.y + playerSpeed;
      }
    }
   }
  }
}

class Ball {
  int x; // X Corodinate
  int y; // Y Coordinate
  int w; // Width
  int h; // Height
  // Help us to control the ball movement
  int ballSpeedX;
  int ballSpeedY;
  
  public Ball(int xc,int yc, int w, int h) {
    this.x = xc;
    this.y = yc;
    this.w = w;
    this.h = h;
    this.ballSpeedX = 5;
    this.ballSpeedY = 5;
  }
  
  void drawBall(){
    ellipse(this.x,this.y,this.w,this.h);
  }
  
  void ballMovement(){
    this.x = this.x + ballSpeedX;
    this.y = this.y + ballSpeedY;
    if (this.x < 0 || this.x > 600) {
      gameOverScreen();
    }
    if (this.y > height - 10 || this.y < 10) {
      ballSpeedY = ballSpeedY * -1;
    }
    // Redirect ball when the player blocks it
    if (ball.y <= player2.y + 100 && ball.y > player2.y && ball.x == player2.x - 10) { //<>//
      ballSpeedX = ballSpeedX * -1;
    }
    if (ball.y < player1.y + 100 && ball.y > player1.y && ball.x == player1.x + 30) {
      ballSpeedX = ballSpeedX * -1;
    } 
    
  }
  
}

// Take input from user
public void mousePressed(){
  // When clicked, start the game
  if(screenType == 0){
     startGame(); 
  }
  if(screenType == 2){
    restartGame();
  }
}

// This method used to signal we start the game
void startGame() {
  screenType=1;
}
void restartGame() {
 ball = new Ball(300,200,30,30);
 player1 = new Player(20,150,20,100);
 player2 = new Player(560,150,20,100);
 screenType = 0;
}
