import org.jbox2d.util.nonconvex.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.testbed.*;
import org.jbox2d.collision.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;
import processing.serial.*;
import generativedesign.*;

/* SETTING VALUES -----------------------------------------------------------*/

Serial myPort; //Serial
Physics physics; //BOXWRAP2D World
Vec2 pointTop, pointMiddle; //Force Vector
Body body; //BOXWRAP2D currnetInnerBox
PFont font; //textFont(Trajan-Pro)
int SerialValue;
int getPos;
int timer, timerC, timerMix;
int timeLimit = 60;
ArrayList myHTML, myHTML2;
ArrayList particles = new ArrayList();
ArrayList textList = new ArrayList();
ArrayList boxList = new ArrayList();
ArrayList textLife = new ArrayList();
ArrayList fSize = new ArrayList();
String currentText, textInner, textInner2;
String searchWord = "Lagrange's_theorem";
String copyRightA = searchWord + " (Feb, " + day() + ", " + year() + ", " + hour() + ":" + minute() + " UTC). in Wikipedia: The Free Encyclopedia. Retrieved from";
String copyRightB = "http://en.wikipedia.org/wiki/" + searchWord;
boolean goA, goB;

/* MAIN -----------------------------------------------------------*/

void setup() {
  size(800, 600);
  frameRate(60);
  smooth();
  physics = new Physics(this, width, height);
  pointTop = new Vec2(0, height/3);
  pointMiddle = new Vec2(0, height);
  goA = true;
  physics.setDensity(10.0f);
  physics.setFriction(1.0f);
  physics.setRestitution(0.1);
  physics.setCustomRenderingMethod(this, "myCustomRenderer");
  myHTML = GenerativeDesign.loadHTMLAsync(this, "http://en.wikipedia.org/wiki/"+ searchWord, GenerativeDesign.HTML_CONTENT);
  font = loadFont("TrajanPro-Regular-48.vlw");
  /* SERIAL */
//  myPort=new Serial(this,Serial.list()[4],9600);
}

void draw() {
  background(0);
  textFont(font);
  textAlign(CENTER);
  rectMode(CENTER);
  
  if(boxList.size() > 0 && textLife.size() > 0) {
    for(int i=0; i < boxList.size(); i++){
      Body Bodier = (Body)(boxList.get(i));
      String Stringer = (String)(textList.get(i));
      int lifer = (Integer)(textLife.get(i));
      int sizer = (Integer)(fSize.get(i));
      Vec2 posW2 = Bodier.getPosition();
      Vec2 posS2 = physics.worldToScreen(posW2);
      float posA = Bodier.getAngle();
      pushMatrix();
      translate(posS2.x, posS2.y);
      if(Stringer.length() == 1) {
        if(lifer > 255) {
          fill(255);
        }else {
          fill(lifer);
        }
      }else if(Stringer.length() > 1) {
        fill(255);
      }
      rotate(-posA);
      textSize(sizer);
      text(Stringer, 0, 8);
      popMatrix();
    }
  }
  
  if(goA == true){
    fill(255);
    if(myHTML.size() != 0) {
      if(textInner == null) textInner = (String)myHTML.get(ceil(random(0, myHTML.size()-1)));
      
      if(textInner.length() > 10 && textCheck(textInner) == true) {
        textInner = textInner.replaceAll(" ", "_");
        println(textInner);
        timerC++;
        if(timerC == 1) myHTML2 = GenerativeDesign.loadHTMLAsync(this, "http://en.wikipedia.org/wiki/"+ textInner, GenerativeDesign.HTML_CONTENT);
        if(timerC == 120) {
          textInner = null;
          timerC = 0;
        }
        
        if(myHTML2.size() != 0) {
          timerC = 0;
          ArrayList myHTML = new ArrayList();
          textInner = null;
          goB = true;
          goA = false;
        }
        
      }else {
        println(textInner);
        textInner = (String)myHTML.get(ceil(random(0, myHTML.size()-1)));
      }
    }
  }
  
  if(goB == true) {
    fill(255);
    if(myHTML2.size() != 0) {
      if(textInner2 == null) textInner2 = (String)myHTML2.get(ceil(random(0, myHTML2.size()-1)));
      
      if(textInner2.length() > 10 && textCheck(textInner2) == true) {
        textInner2 = textInner2.replaceAll(" ", "_");
        println(textInner2);
        timerC++;
        if(timerC == 1){
          myHTML = GenerativeDesign.loadHTMLAsync(this, "http://en.wikipedia.org/wiki/"+ textInner2, GenerativeDesign.HTML_CONTENT);
        }
        if(timerC == 120) {
          textInner2 = null;
          timerC = 0;
        }
        
        if(myHTML.size() != 0) {
          timerC = 0;
          ArrayList myHTML2 = new ArrayList();
          textInner2 = null;
          goA = true;
          goB = false;
        }
        
      }else {
        println(textInner2);
        textInner2 = (String)myHTML2.get(ceil(random(0, myHTML2.size()-1)));
      }
      
    }
  }
  
  if(myHTML != null && myHTML.size() > 0) {
    String textHeader = (String)myHTML.get(0);
    textHeader = textHeader.replaceAll(" - Wikipedia, the free encyclopedia", "");
    int tLength = textHeader.length();
    textSize(60-tLength);
    fill(255, 180);
    text(textHeader, width/2, 100);
    copyRightA = textHeader + " (Feb, " + day() + ", " + year() + ", " + hour() + ":" + minute() + " UTC). in Wikipedia: The Free Encyclopedia. Retrieved from";
    copyRightB = "http://en.wikipedia.org/wiki/" + textHeader;
    timer++;
    if(timer == timeLimit) {
      if(! keyPressed) {
        if(myHTML.size() > 0){
          int textNum = ceil(random(0, myHTML.size()-1));
          currentText = (String)myHTML.get(textNum);
        }
        if(currentText.length() < 30 && currentText.length() > 1 && ! keyPressed && textList.size() < 24){
          getPos = ceil(random(120, 400));
          for(int i=0;i <=5; i++) particles.add(new Particle(getPos, 100));
          createBox(currentText, getPos);
        }
      }
      timer = 0;
    }
  }
  
  if(myHTML2 != null && myHTML2.size() > 0) {
    String textHeader = (String)myHTML2.get(0);
    textHeader = textHeader.replaceAll(" - Wikipedia, the free encyclopedia", "");
    int tLength = textHeader.length();
    textSize(60-tLength);
    fill(255, 180);
    text(textHeader, width/2, 100);
    copyRightA = textHeader + " (Feb, " + day() + ", " + year() + ", " + hour() + ":" + minute() + " UTC). in Wikipedia: The Free Encyclopedia. Retrieved from";
    copyRightB = "http://en.wikipedia.org/wiki/" + textHeader;
    timer++;
    if(timer == timeLimit) {
      if(! keyPressed) {
        if(myHTML2.size() > 0){
          int textNum = ceil(random(0, myHTML2.size()-1));
          currentText = (String)myHTML2.get(textNum);
        }
        if(currentText.length() < 30 && currentText.length() > 1 && ! keyPressed && textList.size() < 24){ 
          getPos = ceil(random(120, 720));
          for(int i=0;i <=5; i++) particles.add(new Particle(getPos, 100));
          createBox(currentText, getPos);
        }
      }
      timer = 0;
    }
  }

/* PARTICLES ----------------------------------------------------------- */
  
  for (int i = 0; i < particles.size(); i++ ) { 
    Particle p = (Particle) particles.get(i);
    p.run();
    p.gravity();
    p.display();
  }
  
  for(int i = 0;i < boxList.size(); i++) {
    String stringer = (String)(textList.get(i));
    int lifer = (Integer)(textLife.get(i));
    
    if(stringer.length() == 1) {
      lifer = lifer - 1;
      if(lifer <= 0){
        removeBox(i);
      }else {
        textLife.set(i, lifer);
      }
    }
  }
  
  if (particles.size() > 100) particles.remove(0);
  
  if(SerialValue == 12) {
    for (int i=0; i < boxList.size() ; i++) {
      Body Bodier = (Body)(boxList.get(i));
      Bodier.applyForce(pointTop.mul(Bodier.m_mass), pointTop);
 
      int lifer = (Integer)(textLife.get(i));
      String stringer = (String)(textList.get(i));
      
      if(stringer.length() == 1 && stringer.indexOf(" ") != -1) {
        removeBox(i);
        return;
      }
      if(stringer.length() > 1){
        lifer = lifer -2;
        if(lifer <= 0) {
          ParagraphSlicer(i);
        }else {
          textLife.set(i, lifer);
        }
      }
    }
  }
  
  if(SerialValue == 21) {
    timerMix++;
    if(timerMix >= 60) {
      for (int i=0; i < boxList.size() ; i++) {
      Body Bodier = (Body)(boxList.get(i));
      Bodier.applyForce(pointMiddle.mul(Bodier.m_mass), pointMiddle);
      }
      timerMix = 0;
    }
  }
  
  if(keyPressed && key == 'r') {
    if(textInner != null) {
      textInner = "Lagrange's_theorem";
    }else if(textInner2 != null) {
      textInner2 = "Lagrange's_theorem";
    }
  }  
  if(keyPressed && key == '1') {
    SerialValue = 21;
  }else if(keyPressed && key == '2') {
    SerialValue = 12;
  }else {
    SerialValue = 22;
  }
  
    
  println(SerialValue);
  
  textAlign(CORNER);
  fill(255, 80);
  textSize(12);
  text(copyRightA, 10, 576);
  text(copyRightB, 10, 588);
}

void serialEvent(Serial p){
  //変数xにシリアル通信で読み込んだ値を代入
  SerialValue = myPort.read();
}

void createBox(String c, int p) {
  String count = c;
  int l = count.length();
  body = physics.createRect(p-(l*7), 100, p+(l*7), 100+20);
  fSize.add(22);
  boxList.add(body);
  textList.add(count);
  textLife.add(20*l);
  body = null;
}

void removeBox(int a) {
  String textCurrent = (String)(textList.get(a));
  int textLength = textCurrent.length();
  textList.remove(a);
  Body Bodier = (Body)(boxList.get(a));
  physics.removeBody(Bodier);
  boxList.remove(a);
  textLife.remove(a);
  fSize.remove(a);
}

void ParagraphSlicer(int a) {
    String textCurrent = (String)(textList.get(a));
    int textLength = textCurrent.length();
    Body Bodier = (Body)(boxList.get(a));
    Vec2 posW2 = Bodier.getPosition();
    Vec2 posS2 = physics.worldToScreen(posW2);
    float posA = Bodier.getAngle();
    for(int i = 0;i < textLength; i++) {
      String t = textCurrent.substring(i,i+1);
      int radX = ceil(random(0, textLength/2));
      body = physics.createRect(posS2.x+radX, posS2.y, posS2.x+radX+20, posS2.y+20);
      boxList.add(body);
      body = null;
      textList.add(t);
      fSize.add(textCurrent.length()*3);
      textLife.add(600);
    }
    for(int i=0;i <=5; i++){
      particles.add(new Particle(ceil(posS2.x), ceil(posS2.y)));
    }
    textList.remove(a);
    physics.removeBody(Bodier);
    boxList.remove(a);
    textLife.remove(a);
    fSize.remove(a);
  }
