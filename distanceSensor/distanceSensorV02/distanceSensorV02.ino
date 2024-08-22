

// Dirk Sardonik didtance sensor example



#include <HCSR04.h>

byte triggerPin = 8;
byte echoCount = 2;
byte* echoPin = new byte[echoCount] {9};

void setup () {
  Serial.begin(115200);
  HCSR04.begin(triggerPin, echoPin, echoCount);
}

void loop () {
  double* distances = HCSR04.measureDistanceCm();
  
  for (int i = 0; i < echoCount; i++) {
    if (i > 0) Serial.print(" | ");
    Serial.print(i + 1);
    Serial.print(": ");
    Serial.print(distances[i]);
    Serial.print(" cm");
  }
  
  Serial.println("");
  delay(500);
}
