#include <HCSR04.h>

// Define pins for four sensors
byte triggerPins[] = {8, 10, 12, 14};
byte echoPins[] = {9, 11, 13, 15};

// Threshold distance in cm (adjust this number)
const double thresholdDistance = 50.0;

// Variables to store time for each sensor
unsigned long objectDetectedTime[4] = {0, 0, 0, 0};
unsigned long objectDetectedDuration[4] = {0, 0, 0, 0};
bool objectDetected[4] = {false, false, false, false};

// Function to convert milliseconds to days, hours, and minutes
void convertMillis(unsigned long ms, unsigned long &days, unsigned long &hours, unsigned long &minutes) {
    days = ms / 86400000;
    ms %= 86400000;
    hours = ms / 3600000;
    ms %= 3600000;
    minutes = ms / 60000;
}

void setup(){
    Serial.begin(9600);
    for (int i = 0; i < 4; i++) {
        HCSR04.begin(triggerPins[i], echoPins[i]);
    }
}

void loop(){
    for (int i = 0; i < 4; i++) {
        double distance = HCSR04.measureDistanceCm(triggerPins[i], echoPins[i]);
        Serial.print("Sensor ");
        Serial.print(i);
        Serial.print(": ");
        Serial.print(distance);
        Serial.println(" cm");

        // Check if the distance is below the threshold
        if(distance < thresholdDistance){
            if(!objectDetected[i]){
                objectDetectedTime[i] = millis();
                objectDetected[i] = true;
            }
            objectDetectedDuration[i] = millis() - objectDetectedTime[i];
        } else {
            objectDetected[i] = false;
            objectDetectedDuration[i] = 0;
        }

        // Convert the duration to days, hours, and minutes
        unsigned long days, hours, minutes;
        convertMillis(objectDetectedDuration[i], days, hours, minutes);

        // Print the duration the object has been detected in days, hours, and minutes
        if(objectDetected[i]){
            Serial.print("Sensor ");
            Serial.print(i);
            Serial.print(" has detected an object for ");
            Serial.print(days);
            Serial.print(" days, ");
            Serial.print(hours);
            Serial.print(" hours, ");
            Serial.print(minutes);
            Serial.println(" minutes.");
        }
    }

    delay(500); // Add a small delay to avoid flooding the serial monitor
}
