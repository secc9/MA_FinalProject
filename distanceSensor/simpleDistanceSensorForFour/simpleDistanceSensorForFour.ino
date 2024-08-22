
//what do I want to do?
// I want to be able to have the distance sensor trigger when movement is detected  at a certain point and at the same time  whilst the sen// sor is broken, pick up that amount of time and log it



// this sketch is the chatgpt updated version
// https://chatgpt.com/share/b68e6ad4-83e8-4cd0-9a85-c52d1cd298a5
// date 2024-08-07

#include <NewPing.h>
// Define the pins for each sensor
#define TRIGGER_PIN1 6
#define ECHO_PIN1 7
#define TRIGGER_PIN2 8
#define ECHO_PIN2 9
#define TRIGGER_PIN3 10
#define ECHO_PIN3 11
#define TRIGGER_PIN4 12
#define ECHO_PIN4 13

// Define maximum distance for each sensor (in centimeters)
#define MAX_DISTANCE 200

// Create NewPing instances for each sensor
NewPing sonar1(TRIGGER_PIN1, ECHO_PIN1, MAX_DISTANCE);
NewPing sonar2(TRIGGER_PIN2, ECHO_PIN2, MAX_DISTANCE);
NewPing sonar3(TRIGGER_PIN3, ECHO_PIN3, MAX_DISTANCE);
NewPing sonar4(TRIGGER_PIN4, ECHO_PIN4, MAX_DISTANCE);

unsigned long detectionStartTimes[4] = {0, 0, 0, 0};  // Start times for detection
unsigned long detectionDurations[4] = {0, 0, 0, 0};   // Detection durations
bool detecting[4] = {false, false, false, false};      // Detection status
unsigned long minDistance = 50;  // Threshold distance for detection (adjust as needed)


//function to convert millis to days, hours and mins




void setup() {
  Serial.begin(9600);
}

void loop() {
  unsigned int distances[4];
  
  // Measure distances
  distances[0] = sonar1.ping_cm();
  distances[1] = sonar2.ping_cm();
  distances[2] = sonar3.ping_cm();
  distances[3] = sonar4.ping_cm();
  
  for (int i = 0; i < 4; i++) {
    if (distances[i] < minDistance && distances[i] > 0) {
      if (!detecting[i]) {
        detecting[i] = true;
        detectionStartTimes[i] = millis();
      }
    } else {
      if (detecting[i]) {
        detecting[i] = false;
        detectionDurations[i] = millis() - detectionStartTimes[i];
        Serial.print("SENSOR");
        Serial.print(i + 1);
        Serial.print("_DURATION:");
        Serial.println(detectionDurations[i]);
	Serial.println(" ms"); // send the duation in miliseconds
      }
    }
  }

  // Debug: Print distances
  for (int i = 0; i < 4; i++) {
    Serial.print("Sensor ");
    Serial.print(i + 1);
    Serial.print(": ");
    Serial.print(distances[i]);
    Serial.println(" cm");
  }

  Serial.println("---");
  delay(250);
}
