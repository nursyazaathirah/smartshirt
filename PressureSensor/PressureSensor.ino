/* Sensor Film Kit force-sensitive LED example
  A tricolor LED indicates the amount of force on the sensor
  This example is for an active-low tri-color LED
*/
 
int analogPin=9;   // potentiometer connected to analog pin 3
int val=0;         // variable to store the read value
int outval=0;
 
void setup()
{
  Serial.begin(9600);
}
 
void loop(void)
{
  val=analogRead(analogPin);   // read the input pin
  Serial.println(val);
  delay(250);
}
