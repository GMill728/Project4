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
import java.util.LinkedList;
import java.util.HashMap;
import processing.sound.*;
SoundFile song;
Scene scene;
String fileName;
PShape E;
PShape goodChestSVG;
PShape evilChestSVG;
PShape obstacleSVG;

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
  fileName = sketchPath("data/save.json");
  File file = new File(fileName);

   try{
  E = loadShape("Enemy.svg");
  goodChestSVG = loadShape("Chest.svg");
  evilChestSVG = loadShape("EvilChest.svg");
  obstacleSVG = loadShape("Rock.svg");

  song = new SoundFile(this, "caveSong.mp3");
  song.loop();}
  catch (NullPointerException e){
    println("one or more files not found... \n terminating program...");
    exit();
  }

  if (file.exists()) {
    JSONObject data = loadJSONObject(fileName);
    scene = new Scene(data, E, goodChestSVG, evilChestSVG, obstacleSVG);
  } else {
    scene = new Scene(E, goodChestSVG, evilChestSVG, obstacleSVG);
    JSONObject data = scene.serialize();
    file.getParentFile().mkdirs();
    saveJSONObject(data, fileName);
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
    saveJSONObject(scene.serialize(), fileName);
  }

  scene.draw();
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
