class Chest extends Interactable {
  private int amount;
  private boolean isBad;
  private boolean interacted;
  PShape goodC;
  PShape badC;
  
  public Chest(PShape goodChest, PShape evilChest)
  {
    this.amount = int(random(10, 21));
    this.isBad = random(1) < 0.5;
    this.interacted = false;
    this.goodC = goodChest;
    this.badC = evilChest;
    
  }

  public JSONObject serialize(){
        JSONObject json = new JSONObject();
        return json; 
    }
  
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
  
  public void draw()
    {
      if (!interacted)
      {
        pushMatrix();
        shapeMode(CENTER);
        shape(goodC, 0, 0, 40, 40);
        popMatrix();
      }
      else
      {
        if(isBad)
        {
          pushMatrix();
          shapeMode(CENTER);
          shape(badC, 0, 0, 40, 40);
          popMatrix();
        }
        else
        {
          pushMatrix();
          shapeMode(CENTER);
          shape(goodC, 0, 0, 40, 40);
          popMatrix();
        }
      }   
        shapeMode(CORNER);
    }
  
}
