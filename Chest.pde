/**
 *      Author: Catherine Garcia
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-05-6
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Chest.pde
 * Description: child class of Interactable, represents a chest.
 */
class Chest extends Interactable {
  private int amount;
  private boolean isBad;
  private boolean interacted;
  PShape goodC;
  PShape badC;
  
  /**
   *      Method: public Chest(PShape goodChest, PShape evilChest)
   *  Parameters: PShape goodChest - The shape to use for the good chest
   *              PShape evilChest - The shape to use for the evil chest
   *      Return: void
   * Description: Constructor for the Chest class
   */
  public Chest(PShape goodChest, PShape evilChest)
  {
    this.amount = int(random(10, 21));
    this.isBad = random(1) < 0.5;
    this.interacted = false;
    this.goodC = goodChest;
    this.badC = evilChest;
    
  }

  public JSONObject serialize(){//placeholder serializations
        JSONObject json = new JSONObject();
        return json; 
    }
  
    /**
   *      Method: public boolean interact(Player player)
   *  Parameters: Player player - The player interacting with the chest
   *      Return: boolean - True if the interaction was successful, false otherwise
   * Description: interactions between player and chest (should disappear)
   */
  public boolean interact(Player player)
  {
    if(interacted)
    {
      return false;
    }
    
    interacted = true;
    
    if(isBad)
    {
      player.updateHealth(-amount);
    }
    else
    {
      player.updateHealth(amount);
    }
    
    return true;
  }
  
  /**
   *      Method: public void draw()
   *  Parameters: void
   *      Return: void
   * Description: Draws the chest
   */
  public void draw()
    {
      if (!interacted)
      {
        pushMatrix();
        shapeMode(CENTER);
        shape(goodC, -5, -10, 40, 40);
        popMatrix();
      }
      else
      {
        if(isBad)
        {
          pushMatrix();
          shapeMode(CENTER);
          shape(badC, -5, -10, 40, 40);
          popMatrix();
        }
        else
        {
          pushMatrix();
          shapeMode(CENTER);
          shape(goodC, -5, -10, 40, 40);
          popMatrix();
        }
      }   
        shapeMode(CORNER);
    }
  
}
