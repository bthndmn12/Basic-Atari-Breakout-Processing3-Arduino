import processing.serial.*;




Serial myPort;
int val;
int xVal;
 int highByte ;
 int lowByte;
   int result;
int vx = 10;
int vy = 10;
boolean reGame = false;
 int xPos,yPos;
 int count = 0;
 

 ArrayList<Blocks> blocks = new ArrayList<Blocks>(); 
 
 
void setup() {
  fullScreen();
  //size(1920,1080);
  noStroke();
  fill(0);
  frameRate(60);
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  

    if(reGame != true){
      for(int i=0; i < width; i+=100){
  for(int j=100; j < height/3; j+=100){
      blocks.add(new Blocks(i,j));
     i+=10;
  }
      }
      
    }

  
}
  

void draw() {
    background(204);
    textSize(50);
    frameRate(60);
   /* if (myPort.available() >= 2) {
        highByte = myPort.read();
        lowByte = myPort.read();
        result = (highByte * 256) + lowByte;
       }*/
  //  val = myPort.read();         // read it and store it in val
  reGame = true;
   if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
  }
  xVal = val*9;
    xPos+=vx;
    yPos+=vy;
    if(xPos == width || xPos == 0){
     vx= -vx;
  }
  if(yPos+500 == height+500 || yPos+500 == 0){
      vy= -vy;
  }
  if(((xPos <= xVal+100) && (xPos >= xVal-100)) && ((yPos+500 <= 1001)&&((yPos+500 >= 999)))){
      vy= -vy;
  }
  if(count == 45){
  exit();
  }
  
  /*if(reGame == true){
      for(int i=0; i < width; i+=100){
  for(int j=100; j < height/3; j+=100){
      blocks.add(new Blocks(i,j));
     i+=10;
  }
      }
  }*/
println(xVal);
  text(Integer.toString(count), width/2, height/2); 
  circle(xPos,yPos+500,20);
  rect((xVal)-100,1000,200,30);
   
    for(int i=0; i < blocks.size(); i++){
        blocks.get(i).display();  
    if(blocks.get(i).boom(xPos,yPos+500) ==  true){
    blocks.remove(i);
    count++;
     vy= -vy;
    }
    
 }
 
 
  
  //println(xPos+" "+yPos+" "+mouseX+" "+mouseY);
}
