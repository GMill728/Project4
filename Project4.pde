/**
 *      Author: Prof. Morales
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-04-15
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Project4.pde
 * Description: A dungeon crawler game
 */
import processing.sound.*;
SoundFile song;
Scene scene;
String fileName;

/**
 *      Method: setup()
 *  Parameters: void
 *      Return: void
 * Description: Constructs a scene from JSON
 *              save data or in a random state
 */

void setup() {
  fullScreen(P2D);
  pixelDensity(1);
  fileName = "data" + File.separator + "save.json";
  File file = new File(fileName);

  try{
  song = new SoundFile(this, "caveSong.mp3");
  song.loop();}
  catch (NullPointerException e){
    println("song not found... \n terminating program...");
    exit();
  }

  if (file.exists()) {
    JSONObject data = loadJSONObject(fileName);
    scene = new Scene(data);
  } else {
    scene = new Scene();
    //!JSONObject data = scene.serialize();
    file.getParentFile().mkdirs();
    //!saveJSONObject(data, fileName);
  }
}

/**
 *      Method: draw()
 *  Parameters: void
 *      Return: void
 * Description: Draws the scene and all objects
 *              within it, additionally performing
 *              logic for the main game loop
 */

void draw() {
  background(0);
  scene.draw();

  if (scene.tryTurn()) {
    // Save the state of the scene
    //!saveJSONObject(scene.serialize(), fileName);
  }

  scene.draw();
  drawMusicControls();
}

/**
 *      Method: keyPressed()
 *  Parameters: void
 *      Return: void
 * Description: Passes key press events to the scene
 */

void keyPressed() {
  scene.keyPressed();
}

/**
 *      Method: keyReleased()
 *  Parameters: void
 *      Return: void
 * Description: Passes key release events to the scene
 */

void keyReleased() {
  scene.keyReleased();
}


void drawMusicControls(){
  fill(255);
  PShape volumeControls = createShape(RECT,20,20,40, 40);
  shape(volumeControls);
  rotate(45);
}
