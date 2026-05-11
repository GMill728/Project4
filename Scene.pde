/**
 *      Author: Prof. Morales
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-04-15
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Scene.pde
 * Description: The game scene that handles each room
 *              and all objects within those rooms,
 *              including the player and enemies
 */
class Scene {
  private int roomWidth;
  private int roomHeight;
  private WorldObject[][] room;
  private Direction entry;
  private Player player;
  private LinkedList<Actor> enemies;
  private HashMap<WorldObject, Position> positions;
  private HashMap<Direction, Position> doors;
  private PShape enemyShape;
  private PShape goodChest;
  private PShape evilChest;
  private PShape obstacle;
  private PShape playerShape;

  private int seed; //seed for proc gen
  private boolean firstStage = true;


  /**
   *      Method: private reset()
   *  Parameters: Direction entry - The direction from which
   *                                the player entered the room
   *      Return: void
   * Description: Resets the room to a random state
   */
   Scene(PShape enemyShape, PShape goodChest, PShape evilChest, PShape obstacle, PShape playerShape) {
    seed = int(random(100000));
    
    this.roomWidth = 12;
    this.roomHeight = 12;
    this.room = new WorldObject[roomWidth][roomHeight];
    this.entry = Direction.NORTH;
    this.player = new Player(Direction.NORTH, playerShape);
    this.enemies = new LinkedList<Actor>();
    this.positions = new HashMap<WorldObject, Position>();
    this.doors = new HashMap<Direction, Position>();
    this.enemyShape = enemyShape;
    this.goodChest = goodChest;
    this.evilChest = evilChest;
    this.obstacle = obstacle;
    this.playerShape = playerShape;

    reset(Direction.NORTH);
   }
   Scene(JSONObject file, PShape enemyShape, PShape goodChest, PShape evilChest, PShape obstacle, PShape playerShape) {

    this.roomWidth = file.getInt("roomWidth");
    this.roomHeight = file.getInt("roomHeight");
    this.seed = file.getInt("seed");
    this.firstStage = file.getBoolean("firstStage");

    this.enemyShape = enemyShape;
    this.goodChest = goodChest;
    this.evilChest = evilChest;
    this.obstacle = obstacle;

    this.room = new WorldObject[roomWidth][roomHeight];
    this.enemies = new LinkedList<Actor>();
    this.positions = new HashMap<WorldObject, Position>();
    this.doors = new HashMap<Direction, Position>();

    //load player
    JSONObject playerData = file.getJSONObject("player");
    this.player = new Player(playerData, playerShape);

    reset(Direction.NORTH);

    int playerX = playerData.getInt("x");
    int playerY = playerData.getInt("y");
    room[playerX][playerY] = player;

    positions.put(player, new Position(playerX, playerY, this));

    //load enemies
    JSONArray enemyArray = file.getJSONArray("enemies");

    for (int i = 0; i < enemyArray.size(); i++) {
        JSONObject enemyData = enemyArray.getJSONObject(i);
        Enemy enemy = new Enemy(Direction.valueOf(enemyData.getString("facing")), enemyShape);

        int enemyX = enemyData.getInt("x");
        int enemyY = enemyData.getInt("y");

        room[enemyX][enemyY] = enemy;

        positions.put(enemy, new Position(enemyX, enemyY, this));
        enemies.add(enemy);
    }
  }


    /**
   *      Method: private reset()
   *  Parameters: Direction entry - The direction from which
   *                                the player entered the room
   *      Return: void
   * Description: Resets the room to a random state
   */
  private void reset(Direction entry) {
    if (entry == null) {
      return;
    }
    //! clear all things once they exist i.e. thing.clear();
    room = new WorldObject [roomWidth][roomHeight];
    positions.clear();
    doors.clear();
    enemies.clear();

    int PSX = roomWidth/2; //Initial player spawn X
    int PSY = roomHeight/2; //Initial player spawn Y
    
    randomSeed(seed); //seeds all random numbers goin forwards
    //! ^ uncomment after testing

    if (firstStage){
      room[PSX][PSY] = player;
      Position pos = new Position(PSX, PSY, this);
      positions.put(player, pos);
    }
    else {
      int spawnX = PSX;
      int spawnY = PSY;

      if (entry == Direction.NORTH) {
        spawnX = roomWidth / 2;
        spawnY = 1;
      }
      else if (entry == Direction.SOUTH) {
        spawnX = roomWidth / 2;
        spawnY = roomHeight - 2;
      }
      else if (entry == Direction.WEST) {
        spawnX = 1;
        spawnY = roomHeight / 2;
      }
      else if (entry == Direction.EAST) {
        spawnX = roomWidth - 2;
        spawnY = roomHeight / 2;
      }

      room[spawnX][spawnY] = player;

      Position pos = new Position(spawnX, spawnY, this);
      positions.put(player, pos);
    }
    
    firstStage = false;

    for (int y = 0; y < roomHeight; y++) {
        for (int x = 0; x < roomWidth; x++) {

            if (room[x][y] != null){ continue; }
            float r = random(1);
            
            //!BUG I believe the player is replacing the door object in tiles... I don't know how to fix this

            boolean isDoor = false;

            if ((x == roomWidth / 2 && y == 0)||(x == roomWidth / 2 && y == roomHeight - 1)
            ||(x == 0 && y == roomHeight / 2)||(x == roomWidth - 1 && y == roomHeight / 2))
            {
              isDoor = true;
            }

            if (isDoor) {
                room[x][y] = new devDoor();
                Direction dir = null;

                if (y == 0) dir = Direction.NORTH;
                else if (y == roomHeight - 1) dir = Direction.SOUTH;
                else if (x == 0) dir = Direction.WEST;
                else if (x == roomWidth - 1) dir = Direction.EAST;

                doors.put(dir, new Position(x, y, this));

                continue;
            }
          
            else if (r < 0.2) {
              Enemy enemy = new Enemy(Direction.SOUTH, enemyShape);
              room[x][y] = enemy;
              Position pos = new Position(x, y, this);

              positions.put(enemy, pos);
              enemies.add(enemy);
            } 
            else if (r < 0.3) { 
              Chest chest = new Chest(goodChest, evilChest);
              room[x][y] = chest;
            }
            else if (r < 0.35) { 
              Obstacle obstacle = new Obstacle(this.obstacle);
              room[x][y] = obstacle;
            }
            else { room[x][y] = null; }
        }
      }
      this.entry = entry;
      
      updateActions(player);
  }

  JSONObject serialize() {
    JSONObject data = new JSONObject();

    data.setInt("roomWidth", roomWidth);
    data.setInt("roomHeight", roomHeight);
    data.setInt("seed", seed);
    data.setBoolean("firstStage", firstStage);

    //seperate section for player info
    JSONObject playerData = player.serialize();
    Position playerPos = positions.get(player);

    playerData.setInt("x", playerPos.getX());
    playerData.setInt("y", playerPos.getY());

    data.setJSONObject("player", playerData);

    //and another for enemies
    JSONArray enemyArray = new JSONArray();
    for (Actor enemy : enemies) {
        JSONObject enemyData = enemy.serialize();

        Position pos = positions.get(enemy);

        enemyData.setInt("x", pos.getX());
        enemyData.setInt("y", pos.getY());

        enemyArray.append(enemyData);
    }
    data.setJSONArray("enemies", enemyArray);

    return data;
  }

  /**
   *      Method: private updateActions()
   *  Parameters: Actor actor - The actor whose actions will be
   *                            updated to reflect their validity
   *      Return: void
   * Description: Updates an actor's list of valid actions
   */

  private void updateActions(Actor actor) {
    for (Action action: Action.values()) {
      actor.setActionValidity(action, this.isActionValid(actor, action));
    }
  }

  /**
   *      Method: public tryTurn()
   *  Parameters: void
   *      Return: boolean - Whether or not the state of
   *                        the scene should be saved
   * Description: Tries to execute a single turn of game
   *              logic for the player and all enemies
   */

  public boolean tryTurn() {
    // If the player is dead, reset the room
    if (this.player == null || this.player.getHealth() == 0) {
      Direction[] directions = Direction.values();
      Direction direction = directions[int(random(directions.length))];
      this.player = new Player(direction, playerShape);
      this.reset(direction);
    }

    // Get the player's action
    Action action = this.player.getAction();

    // If no action was chosen, do nothing
    if (action == null) {
      return false;
    }

    // If the player attacked or entered a new room, save the game
    Position door = this.doors.get(action.direction);
    boolean save = action.isAttack || door != null && door.equals(this.positions.get(this.player)) && this.enemies.size() == 0;

    // If the action failed, do nothing
    if (!this.tryAction(this.player, action)) {
      return false;
    }

    for (int i = 0; i < this.enemies.size(); ++i) {
      Actor enemy = this.enemies.get(i);

      // Remove dead enemies
      if (enemy.getHealth() == 0) {
        this.enemies.remove(i--);
        continue;
      }

      // Get the enemy's action
      this.updateActions(enemy);
      action = enemy.getAction();

      if (this.tryAction(enemy, action) && action.isAttack) {
        // If the player died, reset the room and save the game
        if (player.getHealth() == 0) {
          Direction[] directions = Direction.values();
          Direction direction = directions[int(random(directions.length))];
          this.player = new Player(direction, playerShape);
          this.reset(direction);
          return true;
        }

        // If the enemy attacked, save the game
        save = true;
      }
    }

    this.updateActions(this.player);
    return save;
  }

  /**
   *      Method: private tryAction()
   *  Parameters: Actor  actor  - The actor performing the action
   *              Action action - The action being performed
   *      Return: boolean - Whether or not the action succeeded
   * Description: Tries to execute an action on behalf of an actor
   */

  private boolean tryAction(Actor actor, Action action) {
    if (!isActionValid(actor, action)) {
      return false;
    }

    Position position = this.positions.get(actor);

    if (position == null) {
      return false;
    }

    // Get the position of the cell being targeted
    int x = position.getX() + action.direction.x;
    int y = position.getY() + action.direction.y;

    // Check if the player can enter a new room
    if (!action.isAttack && actor == this.player && action.direction != this.entry.inverse() && this.enemies.size() == 0) {
      Position door = this.doors.get(action.direction);

      if (door != null && door.equals(position)) {
        this.reset(action.direction);
        return true;
      }
    }

    // Check if the actor is facing a wall
    if (x < 0 || x >= this.roomWidth || y < 0 || y >= this.roomHeight) {
      return false;
    }

    // Check if the actor can attack
    if (action.isAttack) {
      boolean isActionValid = this.room[x][y] instanceof Actor && (actor == this.player || this.room[x][y] == this.player);

      if (isActionValid) {
        Actor enemy = (Actor)this.room[x][y];

        if (enemy.getHealth() > 0) {
          enemy.updateHealth(-actor.getDamage());
        } else {
          this.room[x][y] = null;
        }
      }

      return isActionValid;
    }

    // Check if the actor can interact with an interactable object
    if (actor == this.player && this.room[x][y] instanceof Interactable) {
      Interactable interactable = (Interactable)this.room[x][y];

      if (!interactable.interact(this.player)) {
        return false;
      }
    } else if (this.room[x][y] != null) {
      return false;
    }

    // Check if the actor can move
    this.room[x][y] = actor;
    this.room[position.getX()][position.getY()] = null;
    position.move(action.direction);
    return true;
  }

  /**
   *      Method: private isActionValid()
   *  Parameters: Actor  actor  - The actor performing the action
   *              Action action - The action being performed
   *      Return: boolean - Whether or not the action is valid
   * Description: Determines if an actor's action would be valid
   */

  private boolean isActionValid(Actor actor, Action action) {
    if (actor == null || action == null || actor.getHealth() == 0) {
      return false;
    }

    Position position = this.positions.get(actor);

    if (position == null) {
      return false;
    }

    // Get the position of the cell being targeted
    int x = position.getX() + action.direction.x;
    int y = position.getY() + action.direction.y;

    // Check if the player can enter a new room
    if (!action.isAttack && actor == this.player && action.direction != this.entry.inverse() && this.enemies.size() == 0) {
      Position door = this.doors.get(action.direction);

      if (door != null && door.equals(position)) {
        return true;
      }
    }

    // Check if the actor is facing a wall
    if (x < 0 || x >= this.roomWidth || y < 0 || y >= this.roomHeight) {
      return false;
    }

    // Check if the actor can attack
    if (action.isAttack) {
      return this.room[x][y] instanceof Actor && (actor == this.player || this.room[x][y] == this.player);
    }

    // Check if the actor can move
    return this.room[x][y] == null || this.room[x][y] instanceof Interactable && actor == this.player;
  }

  /**
   *      Method: public getRoomWidth()
   *  Parameters: void
   *      Return: int - The width of the room, in number of columns
   * Description: Returns the width of the room
   */

  public int getRoomWidth() {
    return roomWidth;
  }

  /**
   *      Method: public getRoomHeight()
   *  Parameters: void
   *      Return: int - The height of the room, in number of rows
   * Description: Returns the height of the room
   */

  public int getRoomHeight() {
    return roomHeight;
  }

  /**
   *      Method: public keyPressed()
   *  Parameters: void
   *      Return: void
   * Description: Passes key press events to the player
   */

  public void keyPressed() {
    if (this.player != null) {
      this.player.keyPressed();
    }
  }

  /**
   *      Method: public keyReleased()
   *  Parameters: void
   *      Return: void
   * Description: Passes key release events to the player
   */

  public void keyReleased() {
    if (this.player != null) {
      this.player.keyReleased();
    }
  }


  /**
   *      Method: public draw()
   *  Parameters: void
   *      Return: void
   * Description: Draws the scene
   */

  public void draw() {
    
    float size = min((float)width / (this.roomWidth + 2), (float)height / (this.roomHeight + 2));

    PShape tile = createShape(RECT, 0, 0, size, size);
    
    int xInit = (width-(int)(this.roomWidth * size)) / 2;
    int x = xInit;
    int xCenter = roomWidth/2;
    
    int yInit = (height-(int)(this.roomHeight * size)) / 2;
    int y = yInit;
    int yCenter = roomHeight/2; 

    int radius = min(roomWidth, roomHeight) / 2; 

    int fillColor = 255;

    for (int i=0; i<this.roomHeight; i++){
      for (int z=0; z<this.roomWidth; z++){
            /*
            room[z][i] = new WorldObject-type();
            this will spawn a world object at a given tile
            
            room[z][i] = new tmpObj(); is an example
            the above logic should only be used for debugging as reset() populates rooms normallys
            */

            tile.setFill(color(fillColor));

            //below basically cuts the edges of the grid using pathfinding
            
            if (abs(z - xCenter) + abs(i - yCenter) > radius) {
              //this is something I found for pathfinding called manhattan distance on a 
              //youtube video a while ago
              //here's a link to the formula I used on this project:  https://www.geeksforgeeks.org/data-science/manhattan-distance/
              
              x += size;
              continue;
            }

            shape(tile, x, y);

            if (room[z][i] != null) {//if tile not empty then draw contentse

                pushMatrix();
                translate(x + size/2, y + size/2);
                room[z][i].draw();
                popMatrix();
            }

            x += size;
            fillColor -= 1;
            
        }
      y += size;
      x = xInit;
      }
  }
}
