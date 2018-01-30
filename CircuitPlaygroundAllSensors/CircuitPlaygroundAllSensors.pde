// I just added this
// Getting values from Circuit Playground via Serial
//
//  here is the Arduino code for the Serial package:
//
//  Serial.print(CircuitPlayground.motionX());           portValues[0]
//  Serial.print("\t");
//  Serial.print(CircuitPlayground.motionY());           portValues[1]
//  Serial.print("\t");
//  Serial.print(CircuitPlayground.motionZ());           portValues[2]
//  Serial.print("\t");
//  Serial.print(CircuitPlayground.leftButton());        portValues[3]
// Serial.print("\t");
//  Serial.print(CircuitPlayground.rightButton());       portValues[4]
//  Serial.print("\t");
//  Serial.print(CircuitPlayground.lightSensor());       portValues[5]
//  Serial.print("\t");
//  Serial.print(CircuitPlayground.soundSensor());       portValues[6]
//  Serial.print("\t");
//  Serial.println(CircuitPlayground.temperatureF());    portValues[7]
//  delay(20);
//
//  Here's a link to the complete Arduino code:  http://bit.ly/2Ek6inT
//

PImage photo;


import processing.serial.*; 
float[] portValues = new float[8];


Serial myPort;    // The serial port
String inString;  // Input string from serial port


void setup() 
{ 
  size(400, 200);
  frameRate(30);
  rectMode(CENTER);
  photo = loadImage("sound.png");
  
  // change the port name to match yours
  myPort = new Serial(this, "/dev/cu.usbmodem14421", 9600);
  
  // fill up the portValues array with zeros
  for(int i = 0; i<8; i++)
  {
    portValues[i] = 0; 
  }
} 

void draw() { 
  background(255);
  
   // if the current reading is not null, process the values
  if (inString != null) {
    portValues = processSensorValues(inString);
  }
  
  // use sound value to show sound icon
  float soundValue = map(portValues[6],200,1023,0,255);
  if(soundValue > 60) {
     image(photo, 0, 0);
     
  } 
  
  // use the temperature value to change to opacity of the rectangle
  float tempValue = map(portValues[7],77,86,0,255);
 
  
  // get the z value from the accelerometer, use to change rect. size.
  float z = -portValues[2]/3;
  
  // change the fill color based on the button presses
  if(portValues[3] == 1) {
   fill(255,0,0,tempValue); 
  } else if(portValues[4] == 1) {
   fill(0,255,0,tempValue);
  } else {
   fill(0,0,255,tempValue); 
  }
  
  // use the light value to round rectangle corners
  float lightValue = portValues[5];
  

 
  
  // draw resulting rectangle
  rect(width/2+portValues[1]*10, height/2+portValues[0]*10, 40*z, 40*z,lightValue);
  
  println(inString);
} 

//  get values from string you've read in via serial
//  change those values from String to float and store themx  
//  in a new array.  Return this array to be used in draw loop above
float[] processSensorValues(String valString) {
  
  String[] temp = new String[8];
  temp = split(valString,"\t");
  
  if(temp == null) {
    for(int i = 0; i<8; i++) {
      temp[i] = "0"; 
    }
  }
  
  float[] vals = new float[8];
  for(int i = 0; i<8; i++)
  {
    if(temp != null) 
    {
      vals[i] = float(temp[i]); 
    }
    
    else
    {
      vals[i] = 0; 
    }
    
  }
  return vals;
}

// read new data from Serial connection (its a circuit playground
void serialEvent(Serial p) { 
  inString = myPort.readStringUntil(10);  
} 