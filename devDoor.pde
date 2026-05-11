/**
 *      Author: Gavin Mills
 *      Course: CPSC 220
 *  Instructor: Prof. Morales
 *     Created: 2026-05-9
 *         Due: 2026-05-10
 *  Assignment: Project 4
 *        File: devDoor.pde
 * Description: child class of Interactable.  It's a simple door which we
 * ended up keeping.
 */
class devDoor extends Interactable {
    public boolean interact(Player player) {
    return true;
}
    
    public JSONObject serialize(){//placeholder serializations
        JSONObject json = new JSONObject();
        return json; 
    }

    public void draw(){ //draws a simple door

    rectMode(CENTER);
    fill (100,100,0);
    rect(0, 0, 30, 60);
    fill(255,255,0);
    circle(10,5,5);
    rectMode(LEFT);
    }
}
