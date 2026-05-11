/**
 *      Author: Catherine Garcia
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-04-07
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Obstacle.pde
 * Description: The obstacle class represents an obstacle in the game.
 */
class Obstacle extends WorldObject{
  PShape rocks;
  
  public Obstacle(PShape obstacleSVG){
    this.rocks = obstacleSVG;
  }
  
  /** Method: serialize()
   *  Parameters: void
   *     Return: JSONObject
   * Description: Serializes the obstacle to a JSON object.
   */
  public JSONObject serialize() {
    JSONObject object = new JSONObject();
    //object.setInt("maxHealth", this.maxHealth);
    //object.setInt("damage", this.damage);
    return object;
  }
  
  /** Method: draw()
   *  Parameters: void
   *      Return: void
   * Description: Draws the obstacle.
   */
  public void draw()
  {
      pushMatrix();
      shapeMode(CENTER);
      shape(rocks, 0, 0, 40, 40);
      popMatrix();
      
      shapeMode(CORNER);
  }
}
