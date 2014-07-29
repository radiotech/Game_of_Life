int worldSize = 100;
int spaceSize = 8;
int speed = 1;
int delays = 0;
int generations = 0;

boolean seiz = false;
boolean paused = true;


boolean[][] world = new boolean[worldSize][worldSize];
boolean[][] buffer = new boolean[worldSize][worldSize];
color[][] colors = new color[worldSize][worldSize];

boolean drawing = false;
boolean drawer = true;

void setup(){
  size(worldSize*spaceSize,worldSize*spaceSize);
  
  
  for(int i=0; i < worldSize; i++){
    for(int j=0; j < worldSize; j++){
      if(floor(random(2)) == 1){
        world[i][j] = true;
      } else {
        world[i][j] = false;
      }
      colors[i][j] = color(random(255),random(255),random(255));
    }
  }
  
  
}




void draw(){
  
  
  
  if(drawing){
    if(floor(mouseX/spaceSize)>=0 && floor(mouseX/spaceSize)<=worldSize-1){
      if(floor(mouseY/spaceSize)>=0 && floor(mouseY/spaceSize)<=worldSize-1){
        world[floor(mouseX/spaceSize)][floor(mouseY/spaceSize)] = drawer;
      }
    }
  }
  
  delays++;
  
  if(paused == false){
    if(delays >= speed){
      generations++;
      
      for(int i=0; i < worldSize; i++){
        for(int j=0; j < worldSize; j++){
          buffer[i][j] = updateBlock( i, j);
        }
      }
      
      for(int i=0; i < worldSize; i++){
        for(int j=0; j < worldSize; j++){
          world[i][j] = buffer[i][j];
        }
      }
      
      delays = 0;
      
      
    }
  }
  
  if(seiz){
    background(random(255),random(255),random(255));
  } else {
    background(255);
  }
  
  rectMode(CORNER);
  fill(0);
  for(int i=0; i < worldSize; i++){
    for(int j=0; j < worldSize; j++){
      if(world[i][j]){
        if(seiz){fill(colors[i][j]);}
        rect(i*spaceSize,j*spaceSize,spaceSize,spaceSize);
      }
    }
    line(0,i*spaceSize+spaceSize,worldSize*spaceSize,i*spaceSize+spaceSize);
    line(i*spaceSize+spaceSize,0,i*spaceSize+spaceSize,worldSize*spaceSize);
  }
  
  noFill();
  rect(0,0,worldSize*spaceSize-1,worldSize*spaceSize-1);
  
  fill(255);
  rect(0,0,14*spaceSize,2*spaceSize);
  fill(0);
  text("Generation - " + generations,3,13);
}

void mousePressed(){
  drawing = true;
  if(mouseButton == LEFT){
    drawer = true;
  } else {
    drawer = false;
  }
}

void mouseReleased(){
  drawing = false;
}

boolean updateBlock(int XPos, int YPos){
  boolean myreturn = world[XPos][YPos];
  int tempCount = 0;
  
  if(checkWorld(XPos+1,YPos)){tempCount++;}
  if(checkWorld(XPos+1,YPos+1)){tempCount++;}
  if(checkWorld(XPos,YPos+1)){tempCount++;}
  if(checkWorld(XPos-1,YPos+1)){tempCount++;}
  if(checkWorld(XPos-1,YPos)){tempCount++;}
  if(checkWorld(XPos-1,YPos-1)){tempCount++;}
  if(checkWorld(XPos,YPos-1)){tempCount++;}
  if(checkWorld(XPos+1,YPos-1)){tempCount++;}
  
  if(tempCount < 2){myreturn = false;}
  if(tempCount > 3){myreturn = false;}
  if(tempCount == 3){myreturn = true;}
  
  return myreturn;
}

boolean checkWorld(int tempXPos, int tempYPos){
  boolean myreturn = false;
  if(tempXPos > 0 && tempXPos < worldSize-1){
    if(tempYPos > 0 && tempYPos < worldSize-1){
      myreturn = world[tempXPos][tempYPos];
    }
  }
  
  return myreturn;
}

void keyPressed(){
  if(key == ' '){
    if(paused){
      paused = false;
    } else {
      paused = true;
    }
  }
  if(key == 'C' || key == 'c'){
    for(int i=0; i < worldSize; i++){
      for(int j=0; j < worldSize; j++){
        
          world[i][j] = false;
        
      }
    }
    generations = 0;
  }
  if(key == 'S' || key == 's'){
    if(seiz){
      seiz = false;
    } else {
      seiz = true;
    }
  }
  if(key == 'R' || key == 'r'){
    for(int i=0; i < worldSize; i++){
      for(int j=0; j < worldSize; j++){
        if(floor(random(2)) == 1){
          world[i][j] = true;
        } else {
          world[i][j] = false;
        }
      }
    }
    generations = 0;
  }
  if(keyCode == UP){
    speed-=1;
    if(speed < 1){
      speed = 1;
    }
  }
  if(keyCode == DOWN){
    speed++;
  }
}
