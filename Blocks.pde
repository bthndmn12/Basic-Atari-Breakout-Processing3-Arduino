
class Blocks{
  int xBlocks,yBlocks;
  boolean die;
int xSize,ySize;
    Blocks(int xB,int yB){
      xBlocks = xB;
      yBlocks = yB;
    }
    
      void display(){
      rect(xBlocks,yBlocks,50,20);
}   

boolean boom(int x,int y){
    die = false;
  if(((x <= xBlocks+100)&&(x>=xBlocks))&&((y<=yBlocks+50)&&(y>=yBlocks))){
      die = true;
  }
    return die;
}

}
