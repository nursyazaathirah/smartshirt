#include <binary.h>

byte data = 0;
boolean step_taken;
int body_temp; //needs to be between 0 and 32
int BPM;
boolean danger_location;
boolean danger_hit;
boolean byte_flag = true;

void setup() {
  Serial.begin(9600);
  step_taken = true;
  body_temp = 15;
  BPM = 100/10;
  danger_hit = true;
  danger_location = 0;
}

void loop() {
  data = 0;
  // Transfer the byte with BPM information
  if (byte_flag) {
    data = data | step_taken | (body_temp << 1) | (danger_hit << 6) | (danger_location << 7);
  }
  else {
  // Transfer the byte with temperature information
    data = data | step_taken | (BPM << 1) | (danger_hit << 6) | (danger_location << 7);
  }
  
  // Flip byte flag
  byte_flag = !byte_flag;
  
  // Print to console
  for (int i = 7; i >= 0; i--) {
    Serial.print(bitRead(data, i)); 
  }
  Serial.println();
  
  // Alternate byte every half second
  delay(500);
}

