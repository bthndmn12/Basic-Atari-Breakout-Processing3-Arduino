int paddleWidth = 20;
int paddleHeight = 100;
int paddleSpeed = 4;

int leftPaddleX;
int leftPaddleY;
int rightPaddleX;
int rightPaddleY;

int ballSize = 20;
int ballX;
int ballY;
int ballSpeedX = 3;
int ballSpeedY = 2;

void setup() {
  size(800, 600);
  noStroke();

  leftPaddleX = 30;
  leftPaddleY = height / 2 - paddleHeight / 2;
  rightPaddleX = width - 30 - paddleWidth;
  rightPaddleY = height / 2 - paddleHeight / 2;
  
  ballX = width / 2;
  ballY = height / 2;
}

void draw() {
  background(0);

  // Update paddle positions based on arrow keys and W/S keys.
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP) {
        leftPaddleY -= paddleSpeed;
      } else if (keyCode == DOWN) {
        leftPaddleY += paddleSpeed;
      }
    }
    if (key == 'w' || key == 'W') {
      rightPaddleY -= paddleSpeed;
    } else if (key == 's' || key == 'S') {
      rightPaddleY += paddleSpeed;
    }
  }

  // Keep paddles inside the screen.
  leftPaddleY = constrain(leftPaddleY, 0, height - paddleHeight);
  rightPaddleY = constrain(rightPaddleY, 0, height - paddleHeight);

  // Update ball position.
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // Bounce ball off top and bottom of the screen.
  if (ballY < 0 || ballY > height - ballSize) {
    ballSpeedY = -ballSpeedY;
  }

  // Bounce ball off paddles.
  if ((ballX <= leftPaddleX + paddleWidth && ballY + ballSize >= leftPaddleY && ballY <= leftPaddleY + paddleHeight) || (ballX + ballSize >= rightPaddleX && ballY + ballSize >= rightPaddleY && ballY <= rightPaddleY + paddleHeight)) {
    ballSpeedX = -ballSpeedX;
  }

  // Reset ball if it goes off the screen.
  if (ballX < 0 || ballX > width) {
    ballX = width / 2;
    ballY = height / 2;
    ballSpeedX = -ballSpeedX;
  }

  // Draw paddles and ball.
  fill(255);
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight);
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);
  ellipse(ballX, ballY, ballSize, ballSize);
}
