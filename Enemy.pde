class Enemy extends Actor {
  PShape e;

  public Enemy(Direction direction, PShape enemySVG)
    {
      super(100, 10, direction);
      this.e = enemySVG;
    }
    
    public Action getAction(){
    
    // Convert key to action
    switch (this.facing) {
    case NORTH:
      if(this.getActionValidity(Action.ATTACK_NORTH))
      {
        return Action.ATTACK_NORTH;
      }
      break;

    case SOUTH:
      if(this.getActionValidity(Action.ATTACK_SOUTH))
      {
        return Action.ATTACK_SOUTH;
      }
      break;

    case EAST:
      if(this.getActionValidity(Action.ATTACK_EAST))
      {
        return Action.ATTACK_EAST;
      }
      break;

    case WEST:
      if(this.getActionValidity(Action.ATTACK_WEST))
      {
        return Action.ATTACK_WEST;
      }
      break;
      }
    
    
    Action[] moves = {
      Action.MOVE_NORTH,
      Action.MOVE_SOUTH,
      Action.MOVE_EAST,
      Action.MOVE_WEST
      
    };
  
    for(int i = 0; i < moves.length; i++)
    {
      int index = int(random(moves.length));
      Action action = moves[index];
      
      if(this.getActionValidity(action))
      {
        this.facing = action.direction;;
        return action;
      }
    }
    return null;
}
    
    
    public void draw()
    {
      pushMatrix();
      switch(this.facing)
      {
        case NORTH:
          rotate(HALF_PI);
          break;
        case SOUTH:
          rotate(-HALF_PI);
          break;
        case EAST:
          rotate(PI);
          break;
        case WEST:
          rotate(0);
          break;  
      }
      //call actors/players draw for health bar
      shapeMode(CENTER);
      shape(e, 0, 0, 40, 40);
      popMatrix();
      
      shapeMode(CORNER);
      /*pushStyle();
      fill(255, 0 , 0);
      ellipse(0, 0, 20, 20);
      popStyle();
       */
    }

}
