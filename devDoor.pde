class devDoor extends WorldObject {
    public JSONObject serialize(){
        JSONObject json = new JSONObject();
        return json; 
    }

    public void draw(){
    fill (100,100,0);
    rect(0, 0, 30, 60);
    fill(255,255,0);
    circle(25,30,5);
    }
}
