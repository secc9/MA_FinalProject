#include <HCSR04.h>

// Define the pins for the sensor
const int trigPin = 2;
const int echoPin = 3;

// Initialize the sensor
HCSR04 hc(trigPin, echoPin);

// Variable to store the start time
unsigned long startTime;

// Variable to store the current time
unsigned long currentTime;

void setup() {
  // Start the serial communication
  Serial.begin(9600);

  // Initialize the start time
  startTime = millis();
}

void loop() {
  // Read the distance
  float distance = hc.dist();

  // Get the current time
  currentTime = millis();

  // Calculate the elapsed time in seconds
  unsigned long elapsedTime = (currentTime - startTime) / 1000;

  // Print the distance and elapsed time
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.print(" cm");

  Serial.print(" | Time elapsed: ");
  Serial.print(elapsedTime);
  Serial.println(" seconds");

  // Add a delay to prevent flooding the serial output
  delay(1000);
}
