int ledPin = 10;
int dPin = 12;
boolean pulse = false;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(ledPin, INPUT);
  pinMode(dPin, OUTPUT);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  int x = analogRead(ledPin);
  if (x == 525)
  {
    pulse = true;
    digitalWrite(dPin, HIGH);
  }
  else if (x <= 525)
  {
    pulse = false;
    digitalWrite(dPin, LOW);
  }
  
  
  Serial.println(pulse);
}
