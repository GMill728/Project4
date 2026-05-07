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
    noStroke();
    circle(0, 0, 20);
    }
}