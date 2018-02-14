#include <Adafruit_CircuitPlayground.h>

float X, Y, Z;

void setup() {
  Serial.begin(9600);
  CircuitPlayground.begin();
}

void loop() {
  Serial.print(CircuitPlayground.motionX());
  Serial.print("\t");
  Serial.print(CircuitPlayground.motionY());
  Serial.print("\t");
  Serial.print(CircuitPlayground.motionZ());
  Serial.print("\t");
  Serial.print(CircuitPlayground.leftButton());
  Serial.print("\t");
  Serial.print(CircuitPlayground.rightButton());
  Serial.print("\t");
  Serial.print(CircuitPlayground.lightSensor());
  Serial.print("\t");
  Serial.print(CircuitPlayground.soundSensor());
  Serial.print("\t");
  Serial.println(CircuitPlayground.temperatureF());
  delay(20);

  // {x,y,z,leftButton,rightButton,lightSensor,soundSensor,temperature}
}
