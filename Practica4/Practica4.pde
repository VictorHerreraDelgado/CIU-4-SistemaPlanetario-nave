import java.awt.Point;
PShape spaceship;
boolean cameraMode;
boolean[] keys = new boolean[5];
boolean viewP;
// Posición de la camara/nave
float px,py,pz;
// Posición del punto de vista
float ejeVx,ejeVy,ejeVz;
// Vector de dirección
float dirx, diry,dirz,velVar;

float angleJump;
float angH;

PImage sunImage,chainImage,earthImage,moonImage,waterImage,smokeImage,dustImage,universe;
Planet sun,earth,chain,moon,miniChain1,miniChain2,water,smoke, dust;
int lastWidth,lastHeight;

void setup()
{
  spaceship = loadShape("Quarren Coyote Ship.obj");
  spaceship.scale(0.1);
  angH = 0;
  fullScreen(P3D);
  stroke(0);
  sunImage = loadImage("sun.png");
  chainImage = loadImage("chain.jpg");
  universe = loadImage("universe.jpg");
  earthImage = loadImage("earth.jpg");
  moonImage = loadImage("moon.jpg");
  waterImage = loadImage("water.jpg");
  smokeImage = loadImage("smoke.jpg");
  dustImage = loadImage("dust.jpg");
  createPlanets();
  lastWidth = 0;
  lastHeight = 0;
  angleJump = 2;
  restartSpaceship();
  velVar = 0;
  cameraMode = false;
  viewP = false;
  }

PVector rotatePointX(PVector point,int dir) {
  float cos = (float) Math.cos(radians(dir*angleJump));
  float sin = (float) Math.sin(radians(dir*angleJump));
  float x = point.x * cos  - point.z* sin;
  float z = point.x * sin + point.z * cos;
  
  angH = (angH + dir*angleJump) % 360;
  return new PVector(x, point.y, z);
}

PVector rotatePointY(PVector point,int dir) {
  float cos = (float) Math.cos(radians(dir*angleJump));
  float sin = (float) Math.sin(radians(dir*angleJump));
  float z = point.z * cos  - point.y* sin;
  float y = point.z * sin + point.y * cos;
  
  return new PVector(point.x, y, z);
}

void createPlanets(){
  miniChain1 = new Planet("chained firstMoon",13,chainImage,1,0.1,69,false);
  miniChain2 = new Planet("chained scondMoon",10,chainImage,-1,-0.1,100,false);
  chain = new Planet("chained planet",25,chainImage,0.2,0.2,600,false);
  
  moon = new Planet("Moon",5,moonImage,1.5,0.1,30,false);
  earth = new Planet("Earth",20,earthImage,0.3,0.3,200,false);
  water = new Planet("Watzan",30,waterImage,-0.4,-0.5,400,false);
  smoke = new Planet("Prometheus",20,smokeImage,-0.7,0.5,300,false);
  dust = new Planet("Dust II",35,dustImage,0.4,1,500,false);
  
  sun = new Planet("Sun",40,sunImage,0,0.5,0,false);
  
  earth.appendPlanet(moon);
  chain.appendPlanet(miniChain1);
  chain.appendPlanet(miniChain2);
  sun.appendPlanet(earth);
  sun.appendPlanet(chain);
  sun.appendPlanet(water);
  sun.appendPlanet(smoke);
  sun.appendPlanet(dust);
  
}


void draw(){
  
  if(lastHeight != height || lastWidth != width){
    lastHeight = height;
    lastWidth = width;
    universe.resize(width,height);
  }
  
  background(universe);
  textSize(10);
  
    
  if(cameraMode) {
    keyControl();
    translate(width/2 ,height/2,(height/2.0) / tan(PI*30.0 / 180.0));
    

    camera(px,py,pz, ejeVx, ejeVy, ejeVz, 0, 1, 0); 
    dirx = ejeVx - px; diry = ejeVy - py; dirz = ejeVz - pz;
    float distJ = 10 ;
    translate(px + dirx/distJ,(py + diry/distJ) ,pz + dirz/distJ);
    if(viewP)shape(spaceship);
    else sphere(1);
    
    
    translate(-(px + dirx/distJ),-(py + diry/distJ) ,-(pz + dirz/distJ));
    translate(0,0,-(height/2.0) / tan(PI*30.0 / 180.0));
    drawPlanets();
  }else {
    
    translate(width/2,height/2,+ (height/2.0) / tan(PI*30.0 / 180.0));
    camera(0,0,(height/2.0) / tan(PI*30.0 / 180.0),0,0, 0, 0, 1, 0); 
    
    translate(+px,+py,pz + (height/2.0) / tan(PI*30.0 / 180.0));
    shape(spaceship);
    translate(-px,-py ,-pz - (height/2.0) / tan(PI*30.0 / 180.0));

    drawPlanets();

  }

}
void drawPlanets(){
 pushMatrix();
  text(sun.getName(),-sun.getSize(),-sun.getSize() -10);
  sun.drawPlanetAndSurround();
  popMatrix();
  textSize(20);
  text("Sistema Planetario",0,-height/4); 
}

void keyReleased() {
  if (keyCode == UP) keys[0] = false;
  
  if (keyCode == DOWN) keys[1] = false;

  if (keyCode == LEFT )keys[2] = false;
  if (keyCode == RIGHT)keys[3] = false;
  if(key == ' ') keys[4]=false;
  if(key == 'P' || key == 'p'){
    if (viewP) viewP = false;
    else viewP = true;
  }
}

void keyPressed() {
  if (keyCode == UP) {keys[0] = true;;
                      }
  else if (keyCode == DOWN) {keys[1] = true;}

  if (keyCode == LEFT){ keys[2] = true;
                      }
  
  else if (keyCode == RIGHT ){keys[3] = true;}
  if(key == ' ') keys[4]=true;
  if (keyCode == ENTER && cameraMode) cameraMode = false;
  else if (keyCode == ENTER && !cameraMode) cameraMode = true;
  
  if (key == 'R' || key == 'r'){
    restartSpaceship(); 
  }
}

void keyControl(){
  if(keys[0]) {
      if(ejeVy - py >= py - 1000 ){
        ejeVy -=10;
      }
    };
    if(keys[1]) {
      if(ejeVy + py <= py + 1000 ){
        ejeVy +=10;
      }
    };
    if(keys[3]){
      PVector point = rotatePointX(new PVector(ejeVx - px,ejeVy - py,ejeVz -pz),1);
      ejeVx = point.x + px; ejeVy = point.y +py; ejeVz = point.z + pz;
      spaceship.rotateY(radians(-angleJump));
      
    }
    else if(keys[2]){
      PVector point = rotatePointX(new PVector(ejeVx - px,ejeVy - py,ejeVz -pz),-1);
      ejeVx = point.x + px; ejeVy = point.y +py; ejeVz = point.z + pz;
      spaceship.rotateY(radians(angleJump));
    }
    if(keys[4]){
      if(velVar == 0){ dirx = ejeVx - px; diry = ejeVy - py; dirz = ejeVz - pz;}
      else{ dirx = ejeVx - px; diry = ejeVy - py; dirz = ejeVz - pz;}
      float dirVel = 400 - velVar;
      
      px = px + dirx/dirVel;
      ejeVx = ejeVx + dirx/dirVel;
      py = py + diry/dirVel;
      ejeVy = ejeVy + diry/dirVel;
      pz = pz + dirz/dirVel;
      ejeVz = ejeVz + dirz/dirVel;
     };
}

void restartSpaceship(){
  px= 0;
  py = 0;
  pz = 0;
  ejeVx = 0;//width/2.0;
  ejeVy = 0;//height/2.0;
  ejeVz = -(height/2.0) / tan(PI*30.0 / 180.0);
  if(angH < 0)spaceship.rotateY(radians(angH));
  else spaceship.rotateY(radians(abs(angH)));
  angH = 0;
}
