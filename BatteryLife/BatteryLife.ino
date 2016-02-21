#include <Vcc.h>
#include <Adafruit_NeoPixel.h>

#define PIN            6
#define NUMPIXELS      1
#define NIGHTLEVEL    10

const float VccMin   = 0.0;           // Minimum expected Vcc level, in Volts.
const float VccMax   = 4.5;           // Maximum expected Vcc level, in Volts.
const float VccCorrection = 1.0/1.0;  // Measured Vcc by multimeter divided by reported Vcc

Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

Vcc vcc(VccCorrection);

void setup()
{
  Serial.begin(115200);
  pixels.begin();
}

void loop()
{  
  float v = vcc.Read_Volts();
  Serial.print("VCC = ");
  Serial.print(v);
  Serial.println(" Volts");

  float p = vcc.Read_Perc(VccMin, VccMax);
  pixels.setBrightness(p);
  pixels.setPixelColor(0, pixels.Color(220, 100, 100));
  
  pixels.show();
    
  Serial.print("VCC = ");
  Serial.print(p);
  Serial.println(" %");

  delay(2000);
}
