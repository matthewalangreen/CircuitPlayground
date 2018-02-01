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
//  Serial.print("\t");
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


// loads a library needed to establish a connection to a serial device
// in our case, the serial device is a Circuit Playground
import processing.serial.*;   

// create a new array that will hold on to the sensor values
// from the Circuit Playground
float[] portValues = new float[8];

// create a new serial connection
Serial myPort;

// Create a string that will hold onto all the sensor values
// we will take this string and break it up into 8 parts in 
// other parts of the code
String inString;  


void setup() 
{ 
  size(400, 200);  // canvas size
  frameRate(30); // controls how quickly the animation refreshes
  rectMode(CENTER);  // read more about this here: https://processing.org/reference/rectMode_.html

  // change the port name to match yours
  myPort = new Serial(this, "/dev/cu.usbmodem14111", 9600);
  
  // fill up the portValues array with zeros
  // we do this at the beginning so that we don't have
  // any runtime errors if the circuit playground doesn't work
  // right away.
  for(int i = 0; i<8; i++)
  {
    portValues[i] = 0; 
  }
} 

void draw() { 
  background(255); // make a white background
  
   // this if statement makes sure that Processing is actually
   // reading data from the Circuit Playground BEFORE it runs the function
   // processSensorValues()  
  if (inString != null) {
    portValues = processSensorValues(inString);
  }
  
  // use sound value to light yellow circle if sound is loud enough
  // the map() function is used here, its pretty rad
  // read more about it here: https://processing.org/reference/map_.html
  float soundValue = map(portValues[6],200,1023,0,255);
  if(soundValue > 60) {
    // show a light yellow circle if the sound is loud enough
       fill(255,255,0,255);
       ellipse(width-100,height-100,120,120); 
  } 
  
  // use the temperature value to change to opacity of the rectangle
  float tempValue = map(portValues[7],77,86,0,255);
  
  // change the fill color based on the button presses
  if(portValues[3] == 1) {  // if the left button is pressed...
   fill(255,0,0,tempValue); 
  } else if(portValues[4] == 1) {  // if the right button is pressed...
   fill(0,255,0,tempValue);
  } else {
   fill(0,0,255,tempValue); // if no buttons are pressed
  }
  
  // get the x value from the acceleromoter, use to move object
  float x = map(portValues[1],-10,10,0,width);
   
  // get the y value from the accelerometer, use to move object
  float y = map(portValues[0],-10,10,0,height);
  
  // get the z value from the accelerometer, use to change rect. size.
  float z = -portValues[2]/3;
 
  // use the light value to round rectangle corners
  float lightValue = portValues[5];
  
  // draw rectangle using accelerometer values for position and size
  // use lightValue for opacity.
  //
  // see the reference for rect(a,b,c,d,r) to learn more: https://processing.org/reference/rect_.html
  rect(x, y, 40*z, 40*z,lightValue);
  
  // 
  println(inString);
} 

//  this code gets data from the Circuit Playground
// and packages it up inside of an array.  You can go 
// here to learn more about arrays in Processing: 
// https://processing.org/reference/Array.html
//
// There is some error checking here to make sure the 
// Circuit Playground is reporting values
// the code is still a bit buggy.  If you have any errors
// in lines 138 - 164, just press stop and try again.
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

// read new data from the Circuit Playground
void serialEvent(Serial p) { 
  inString = myPort.readStringUntil(10);  
} 