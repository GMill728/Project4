/**
 *      Author: Gavin Mills
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-05-8
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Wall.pde
 * Description: child class of WorldObject which is temporary
 * for testing, it can change colors and was used to represent different types of objects.
 */
class tmpObj extends WorldObject{
    public int clr = 0;
    public JSONObject serialize(){
        JSONObject json = new JSONObject();
        return json; 
    }

    public void draw(){
    if (clr == 1) {
        fill(255, 0, 0);
    } else if (clr == 2) {
        fill(0, 255, 0);
    } else if (clr == 3) {
        fill(0, 0, 255);
    } else {
        fill(0);
    }
    circle(0, 0, 20);
    }
}