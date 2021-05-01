//Mehmet Batuhan Duman


import processing.sound.*;
import processing.serial.*;


Serial myPort;                       
int[] serialInArray = new int[2];   
int serialCount = 0;                 
float xpos, ypos;                
boolean firstContact = false;      

int xPos;
int yPos;

int speed = 10;
int vx = speed;
int vy = speed;

int countP1 = 0;
int countP2 = 0;

boolean effect = false;
boolean start = false;
boolean textStart = false;
Pulse pulse;
Pulse music;
LineEffect lest;
screenNoise sNoise;
color randCol;
int rand;

void setup() {

  fullScreen();
  frameRate(60);
  noStroke();      
  noCursor();
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);


  xPos = width/2;
  yPos = height/2;

  lest = new LineEffect(height, width, 10);
  sNoise = new screenNoise(height, width);

  pulse = new Pulse(this);
  pulse.amp(0.01);
  pulse.play();

  blendMode(EXCLUSION);
}

void draw() {
  background(0);

  println(frameRate); 

  if (effect == true) {
    sNoise.sNeffect();
    lest.lines();
  }
  if (start == false) {

    textSize(50);
    text("Press 'W' for Play", width/4, height/3);
    text("Press 'S' for On Effect", width/4, height/3+100);
    text("Press 'A' for Off Effect", width/4, height/3+200);
    text("Press 'D' for EXIT", width/4, height/3+300);
  }
  if (start == true) {
    textSize(100);
    text(countP1/12, 100, 100);
    text(countP2/12, 1700, 100);
    rect(1820, xpos, 30, 200, 10);
    rect(100, ypos, 30, 200, 10);
    circle(xPos, yPos, 20);
    stroke(255);
    line(width/2, 0, width/2, height);
  }


  xPos+=vx;
  yPos+=vy;

  //  if((xPos <= width+speed && xPos >= width)||(xPos <= speed && xPos >= 0)){
  //   vx= -vx;
  //   pulse.stop();
  //}
  if ((yPos <= height+speed/2 && yPos >= height) || (yPos <=speed && yPos >= 0)) {
    vy= -vy;
    pulse.stop();
  }
  if (((xPos <= 130) && (xPos >=99)) && ((yPos <= ypos+200) && ((yPos >=ypos)))) {
    vx= -vx;
    pulse.play();
  }
  if (((xPos <= 1850) && (xPos >=1820)) && ((yPos <= xpos+200) && ((yPos >=xpos)))) {
    vx= -vx;
    pulse.play();
  }
  if ((xPos >= 1830)) {
    countP1++;
  }
  if ((xPos >= 0)&&(xPos<=130)) {
    countP2++;
  }
  if ((xPos > 150)&&(xPos<1800)) {
    pulse.stop();
  }
  if ((xPos <= 20)&&(xPos>=0)||(xPos >= 1900)&&(xPos<=1920)) {
    xPos = width/2;
    yPos = height/2;
  }
  if (countP1/12 == 10 && countP2/12<10) {
    start = false;
    text("P1 WINS", 100, 100);
  }
  if (countP2/12 == 10 && countP1/12<10) {
    start = false;
    text("P2 WINS", 100, 100);
  }
}

void serialEvent(Serial myPort) {
  int inByte = myPort.read();

  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          
      firstContact = true;    
      myPort.write('A');
    }
  } else {
    serialInArray[serialCount] = inByte;
    serialCount++;

    if (serialCount > 1 ) {
      xpos = serialInArray[0]*4.5;
      ypos = serialInArray[1]*4.5;


      myPort.write('A');
      serialCount = 0;
    }
  }
}
void keyPressed() {
  if (key == 'a' || key == 'A') {
    effect = false;
  } else if (key == 's' ||key == 'S') {
    effect = true;
    speed=50;
  } else if (key == 'd' || key == 'D' ) {
    exit();
  } else if (key == 'w' || key == 'W') {
    start = true;
    countP1 = 0;
    countP2 = 0;
    xPos = width/2;
    yPos = height/2;
  }
}
