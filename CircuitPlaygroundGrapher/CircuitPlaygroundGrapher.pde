import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
String[] valStrings = new String[10000]; // Save up to 10k values

int xPos = 0;
float sensorValue = 0;
int sensorNumber = 5;
int stringIndex = 0;

void setup() {
  size(640, 480);
  background(0);
  stroke(255);
  strokeWeight(2);
  smooth();
  noFill();

    
  // Prints out the available serial ports.
  // println(Arduino.list());
  arduino = new Arduino(this, "/dev/cu.usbmodem14111", 9600);
  
  for(int i = 0; i< 9999; i++) {
    valStrings[i] = "0";
  }
}

void draw() {
  arduino.analogRead(sensorNumber);
  fill(255);
  textSize(16);
  text("Press Any Key to save data to file", 40,40);
  xPos++;
  stringIndex++;
  if(stringIndex > 9999) {
    stringIndex = 0;
  }
  fill(255);
  sensorValue = map(arduino.analogRead(sensorNumber),0,400,0,width);
  valStrings[stringIndex] = str(sensorValue);
  
  ellipse(xPos,sensorValue, 5, 5);
  if (xPos > width) 
  {
    xPos = 0;
    background(0);
  }
}

void keyPressed()
{
  println("values: ", valStrings);
  saveStrings("values.txt", valStrings);
  fill(255,0,0);
  text("Data Saved", width - 100, height - 20);
 
}