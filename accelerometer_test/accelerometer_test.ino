#include <Wire.h>
#include <Adafruit_LSM303.h>

Adafruit_LSM303 lsm;
byte step_taken;

void setup() 
{
  Serial.begin(9600);
  lsm.begin();
}

void loop() 
{
  lsm.read();

  //Calculate the acceleration vector
  int acc_vector = sqrt(pow((int)lsm.accelData.x,2) + pow((int)lsm.accelData.y,2) + pow((int)lsm.accelData.z,2));
  
  //Check for step and set bit to 1 if step is detected
  if (acc_vector < 800)
  {
      step_taken = 1;
      //Serial.println(step_taken);
      delay(220);
  }
  else
  {
      step_taken = 0;
  }
}
