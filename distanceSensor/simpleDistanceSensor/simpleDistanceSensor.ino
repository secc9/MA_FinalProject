
//what do I want to do?
// I want to be able to have the distance sensor trigger when movement is detected  at a certain point and at the same time  whilst the sen// sor is broken, pick up that amount of time and log it



// this sketch is the chatgpt updated version
// https://chatgpt.com/share/b68e6ad4-83e8-4cd0-9a85-c52d1cd298a5
// 2024-07-29




#include <HCSR04.h>


//define pins
byte triggerPins[4] = {6, 8, 10, 12};
byte echoPins[4] = {7, 9, 11, 13};


// Threshold distance in cm (adjust this number)
const double thresholdDistance = 50.0;


// variables to store time
unsigned long objectDetectedTime = 0;
unsigned long objectDetectedDuration = 0;
bool objectDetected = false;



void setup(){
     Serial.begin(9600);

HCSR04.begin(triggerPin, echoPin);
}


void loop(){

     double* distances = HCSR04.measureDistanceCm();
     double distance = distances[0];
     Serial.println(" cm");
     

     // check if the distance is below the threshold
     if(distance < thresholdDistance){
     		 if(!objectDetected){
			//Object just detected
			objectDetected = true;
			objectDetectedTime = millis();
			Serial.println("Object detected!");
		 }
	}else{
		if(objectDetected){
			objectDetected = false;
			objectDetectedDuration = millis() - objectDetectedTime;
			Serial.print("Object deteced duration: ");
			Serial.print(objectDetectedDuration);
			Serial.println(" ms");


// Send the duration to processing

   Serial.print("DURATION:");
   Serial.println(objectDetectedDuration);
		}
	}

Serial.println("---");
delay(250);

}






////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////




/*


// this is the simple distance sensor example from the HCSR04 example library


#include <HCSR04.h>

byte triggerPin = 8;
byte echoPin = 9;

void setup () {
  Serial.begin(9600);
  HCSR04.begin(triggerPin, echoPin);
}

void loop () {
  double* distances = HCSR04.measureDistanceCm();
  
  Serial.print("1: ");
  Serial.print(distances[0]);
  Serial.println(" cm");
  
  Serial.println("---");
  delay(250);
}


*/