class Enemy extends Actor {

  public Enemy(Direction direction)
    {
      super(100, 10, direction);
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
      //call actors/players draw for health bar
      
      pushStyle();
      fill(255, 0 , 0);
      ellipse(0, 0, 20, 20);
      popStyle();
       
    }

}
