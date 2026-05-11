class Enemy extends Actor {
  PShape e;

  public Enemy(Direction direction, PShape enemySVG)
    {
      super(100, 10, direction);
      this.e = enemySVG;
    }
    
    public JSONObject serialize() {
    JSONObject object = super.serialize();
    object.setString("className", "Enemy");
    return object;
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
    
    
    Action[] actions = {
      Action.MOVE_NORTH,
      Action.MOVE_SOUTH,
      Action.MOVE_EAST,
      Action.MOVE_WEST,
      Action.ATTACK_NORTH,
      Action.ATTACK_EAST,
      Action.ATTACK_WEST,
      Action.ATTACK_SOUTH


      
    };
    
    Action action = actions[int(random(actions.length))];
    if(this.getActionValidity(action)){
      this.facing = action.direction;
      return action;
    }

    return null;
}
    
    
    public void draw()
    {
      pushMatrix();
      switch(this.facing)
      {
        case NORTH:
          scale(1, 1);
          break;
        case SOUTH:
          scale(1, 1);
          break;
        case EAST:
          rotate(0);
          scale(-1, 1);
          break;
        case WEST:
          rotate(0);
          scale(1, 1);
          break;  
      }
      //call actors/players draw for health bar
      shapeMode(CENTER);
      shape(e, 0, 0, 40, 40);
      drawEnemyHealthBar();
      popMatrix();
      
      shapeMode(CORNER);
    }

}
