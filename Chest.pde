class Chest extends Interactable {
  private int amount;
  private boolean isBad;
  private boolean interacted;
  PShape goodC;
  PShape badC;
  
  public Chest(PShape goodChest, PShape evilChest)
  {
    this.amount = int(random(10, 21));
    this.isBad = random(2) == 0;
    this.interacted = false;
    this.goodC = goodChest;
    this.badC = evilChest;
    
  }
  
  public Chest(JSONObject json, PShape goodChest, PShape evilChest) {
    this.amount = json.getInt("amount");
    this.isBad = json.getBoolean("isBad");
    this.interacted = json.getBoolean("interacted");
    this.goodC = goodChest;
    this.badC = evilChest;
  }

  public JSONObject serialize(){
        JSONObject json = new JSONObject();
        json.setInt("amount", amount);
        json.setBoolean("isBad", isBad);
        json.setBoolean("interacted", interacted);
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
