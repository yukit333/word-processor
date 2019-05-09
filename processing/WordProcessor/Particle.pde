// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 23-2: Simple particle system with ArrayList

// A simple Particle class
class Particle {
  
  float x;
  float y;
  float xspeed;
  float yspeed;
  int textIn;
  int fader;
  
  Particle(int gPosX, int gPosY) {
    x = gPosX;
    y = gPosY;
    fader = 180;
    xspeed = random(-2,2);
    yspeed = random(-3,0);
    textIn = ceil(random(0, 9));
  }
  
  void run() {
    x = x + xspeed;
    y = y + yspeed;
  }
  
  void gravity() {
    yspeed += 0.05;
    fader = fader -2;
  }
  
  void display() {
    noStroke();
    fill(180, fader);
    textSize(16);
    text(textIn, x, y);
  }
}
