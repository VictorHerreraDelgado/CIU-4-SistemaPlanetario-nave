class Planet{
  private String name;
  private int size;
  private float speed,rotSpeed,actualAng,actualRotAng;
  private float distanceFromAxis;
  private PShape shape;
  private ArrayList<Planet> surround;
  private boolean specialMov;
  public Planet(String name,int size,PImage texture,float speed,float rotSpeed, float distance, boolean specMov){
    actualAng = 0;
    actualRotAng = 0;
    shape = createShape(SPHERE,size);
    shape.setTexture(texture);
    shape.setStroke(100);
    this.speed = speed; this.rotSpeed = rotSpeed;
    distanceFromAxis = distance;
    surround = new ArrayList<Planet>();
    specialMov = specMov;
    this.name = name;
    this.size = size;
  }
  

  public float getSpeed(){
    return speed;
  }
  
  public float getRotSpeed(){
    return rotSpeed;
  }
  
  public float getActAng(){
    return actualAng;
  }
  public float getDistance(){
    return distanceFromAxis;
  }
  public int getSize(){
    return size;
  }
  public String getName(){
    return name;
  }
  
  public boolean isSpecial(){
    return specialMov;
  }
  public void drawPlanetAndSurround(){
    textAlign(CENTER);
    pushMatrix();
    rotateY(radians(actualRotAng));
    shape(shape);
    popMatrix();
    
    actualAng+=speed;
    if (actualAng >= 360 || actualAng <= -360) actualAng = 0;
    actualRotAng+=rotSpeed;
    if (actualRotAng >= 360 || actualRotAng <= -360) actualRotAng = 0;
    
    if(surround.isEmpty()) return;
    for(Planet astro : surround){
      pushMatrix();
      
      if(astro.isSpecial()) rotateZ(radians(astro.getActAng()));
      else rotateY(radians(astro.getActAng()));
      translate(astro.getDistance(),0,0);
      astro.drawPlanetAndSurround();
      if(astro.isSpecial()) rotateZ(radians(-astro.getActAng()) );
      else rotateY(-radians(astro.getActAng()));
      text(astro.getName(),0,-astro.getSize() -10);
      popMatrix();
    }
    
  }
  
  public void appendPlanet(Planet astro){
    surround.add(astro);
  }
  
}
