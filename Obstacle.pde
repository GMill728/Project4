class Obstacle extends WorldObject{
  PShape rocks;
  
  public Obstacle(PShape obstacleSVG){
    this.rocks = obstacleSVG;
  }
  
  public Obstacle(JSONObject json, PShape obstacleSVG) {
  this.rocks = obstacleSVG;
}

  public JSONObject serialize() {
    JSONObject object = new JSONObject();
    object.setString("className", "Obstacle");
    return object;
  }
  
  public void draw()
  {
      pushMatrix();
      shapeMode(CENTER);
      shape(rocks, 0, 0, 40, 40);
      popMatrix();
      
      shapeMode(CORNER);
  }
}
