/**
 *      Author: Gavin Mills
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-05-9
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: Wall.pde
 * Description: child class of WorldObject representing a wall, it's
 * only purpose is to block player movement so it doesn't need serialization.
 */
class Wall extends WorldObject{
    public JSONObject serialize(){//placeholder serialize method
        JSONObject json = new JSONObject();
        return json; 
    }
    public void draw(){}    
}